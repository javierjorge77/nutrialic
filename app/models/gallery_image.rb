class GalleryImage < ApplicationRecord  
    belongs_to :professional, dependent: :destroy
end