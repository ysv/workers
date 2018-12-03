# frozen_string_literal: true

class KafkaListener
  extend Memoist

  attr_reader :consumer_name, :configuration

  class << self
    def call(*args)
      new(*args).call
    end
  end

  def initialize(consumer_name)
    @consumer_name = consumer_name.to_sym
    @configuration =
      Rails.configuration.x.consumers_configuration.fetch(@consumer_name)
    Kernel.at_exit { unlisten }
  end

  def call
    consumer
    listen
  end

  private

  def listen
    unlisten

    @session = Kafka.new([configuration[:kafka]])
    @listener = @session.consumer(group_id: configuration[:group_id])
    configuration[:topics].each {|topic| @listener.subscribe(topic)}

    @listener.each_message(&method(:handle_message))
  end

  def unlisten
    if @session || @listener
      Rails.logger.info { 'No longer listening for events.' }
    end

    @listener&.stop
    @session&.close
  ensure
    @listener = nil
    @session  = nil
  end

  def handle_message(message)
    Rails.logger.info do
      "Received message\n#{message.as_json}\n"
    end
    if configuration[:keys].blank? || message.key.in?(configuration[:keys])
      consumer.call(JSON.parse(message.value))
    else
      Rails.logger.warn do
        [
          "Skipped message",
          message.as_json,
          "Message key should be in #{configuration[:keys].join(',')}"
        ].join("\n") + "\n"
      end
    end
  rescue StandardError => e
    Rails.logger.error { e.inspect + "\n" }
  end

  def consumer
    "#{@consumer_name}_consumer".camelize.constantize.new
  end
  memoize :consumer
end
