def set_mongoid_log_level(level)
  Mongoid.logger.level = level
  Moped.logger.level = level
end

Rails.configuration.log_level == :debug || Rails.configuration.log_level == :test ? set_mongoid_log_level(Logger::DEBUG) : set_mongoid_log_level(Logger::INFO)