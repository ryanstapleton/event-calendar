CarrierWave.configure do |config|
  config.storage    = :file
  # config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
  config.aws_acl    = 'public-read'

 config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

 config.aws_attributes = {
    expires: 1.week.from_now.httpdate,
    cache_control: 'max-age=604800'
  }

end