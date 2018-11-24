# frozen_string_literal: true

class ExampleConsumer
  def call(*args)
    Rails.logger.info { "I'm Example listener" }
  end
end
