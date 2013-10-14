# encoding: utf-8

class NewsletterUploader < BaseUploader
  
  version :thumb do
    process :resize_to_fit => [170, 120]
  end
end
