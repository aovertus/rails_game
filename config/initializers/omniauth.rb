OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, "819645324747529", "8f88419be1de73049ead31c2d4bc0027"
  provider :facebook, "819646658080729", "73b971f854f1a4e9207bde433b5f8343"
end

