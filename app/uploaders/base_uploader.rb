# -*- encoding : utf-8 -*-
class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  alias original_url url

  storage :file
  
  def store_dir
    "assets/#{filename[0..1]}" unless filename.blank?
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest("aloe--#{File.dirname(current_path)}--#{original_filename}")
      "#{@name}.#{file.extension}"
    end
  end
  
  def url
    unless original_url.blank?
      hashed_name = original_url.scan(/[a-z0-9]{32}/)[0]
      File.join('/assets', hashed_name[0..1], original_url[1..(original_url.length - 1)])
    end
  end
end
