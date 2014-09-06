OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '819645324747529', '8f88419be1de73049ead31c2d4bc0027',
  {:client_options => {:ssl => {:ca_path => "C:\RailsInstaller\cacert.pem"}}}
end



