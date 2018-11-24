# frozen_string_literal: true

class KafkaListener
  extend Memoist

  class << self
    def call(*args)
      new(*args).call
    end
  end

  def initialize(consumer_name)
    @consumer_name = consumer_name
    Kernel.at_exit { unlisten }
  end

  def call
    binding.pry
    consumer
    listen
  end

  private

  def listen

  end

  def unlisten

  end

  def consumer
    "#{@consumer_name}_consumer".camelize.constantize
  end
  memoize :consumer
end