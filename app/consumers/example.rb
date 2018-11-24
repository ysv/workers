module Listeners
  class Example
    def call(*args)
      Rails.logger.info { "I'm Example listener" }
    end
  end
end