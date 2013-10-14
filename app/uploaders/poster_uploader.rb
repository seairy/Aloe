# encoding: utf-8

class PosterUploader < BaseUploader
  
  version :thumb do
    process :resize_to_fit => [200, 200]
  end
end
