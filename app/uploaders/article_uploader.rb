# -*- encoding : utf-8 -*-
class ArticleUploader < BaseUploader
  
  version :thumb do
    process :resize_to_fit => [120, 80]
  end
end
