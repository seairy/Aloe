# -*- encoding : utf-8 -*-
class BookUploader < BaseUploader
  
  version :thumb_small do
    process :resize_to_fit => [210, 300]
  end
  
  version :thumb_tiny do
    process :resize_to_fit => [105, 150]
  end
end
