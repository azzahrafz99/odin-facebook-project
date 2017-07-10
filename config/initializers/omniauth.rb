OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['1404448866316456'], ENV['0775b864c92a2ea803302fe9f13035cd']
end
