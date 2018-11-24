# frozen_string_literal: true

class ExampleConsumer
  def call(message)
    Rails.logger.info { "Example listener received #{message}" }
  end
end
