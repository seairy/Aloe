# -*- encoding : utf-8 -*-
class PublicationVolumeUploader < BaseUploader
  
  version :thumb do
    process :resize_to_fit => [105, 150]
  end
end
