class AboutSection < ApplicationRecord
    has_rich_text :content
    belongs_to :professional
end