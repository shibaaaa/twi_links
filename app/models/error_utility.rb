# frozen_string_literal: true

class ErrorUtility
  def self.log(e)
    Rails.logger.error e.class
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end
end
