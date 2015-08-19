Apipie.configure do |config|
  config.app_name                = "DraftKings"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/docs/api"
  config.use_cache               = true
  config.validate                = false
  config.app_info["1.0"] = "
    API URL is 'localhost:3000/api/v1'
  "
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
