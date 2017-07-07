Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '841530092677917', '6379c56f299b315850e28da8115470ae', {:provider_ignores_state => true}
end
