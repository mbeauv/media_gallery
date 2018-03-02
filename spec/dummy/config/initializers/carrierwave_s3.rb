class UrbanoeFogSettings

  def self.S3
    {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['MEDIA_GALLERY_TEST_AWS_PUBLIC'],
      :aws_secret_access_key  => ENV['MEDIA_GALLERY_TEST_AWS_SECRET']
    }
  end

  def self.directory
    ENV['MEDIA_GALLERY_TEST_AWS_DIR']
  end

end

CarrierWave.configure do |config|

  config.fog_credentials = UrbanoeFogSettings.S3
  config.fog_directory   = UrbanoeFogSettings.directory

  #The following is specifically for Heroku.  Heroku only allows you to save data
  #in the tmp folder.  We therefore make sure that the tmp files are put there.
  #See https://github.com/jnicklas/carrierwave/wiki/How-to%3A-Make-Carrierwave-work-on-Heroku
  config.cache_dir = "#{Rails.root}/tmp/uploads"

end
