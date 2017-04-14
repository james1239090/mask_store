CarrierWave.configure do |config|
  if Rails.env.producttion?
    config.storage :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['aws_access_key_id'],
      aws_secret_access_key: ENV['aws_secret_access_key'],
      region: 'ap-northeast-1'
    }
    config.fog_directory = 'maskstore'
  else
    config.storage :file
  end
end

