# config/initializers/active_storage.rb
Rails.application.config.after_initialize do
  ActiveStorage::Current.url_options = { host: ENV.fetch("HOST", "localhost"), protocol: ENV.fetch("PROTOCOL", "http") }
end
