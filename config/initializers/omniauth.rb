OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['841530092677917'], ENV
  ['6379c56f299b315850e28da8115470ae']
end
