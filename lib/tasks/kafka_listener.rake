# frozen_string_literal: true

task kafka_listener: :environment do
  Rails.logger = ActiveSupport::Logger.new(STDOUT, level: :debug)

  KafkaListener.call \
    ENV.fetch('KAFKA_CONSUMER_NAME')
end
