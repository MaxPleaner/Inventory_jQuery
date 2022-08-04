class Tag < ApplicationRecord
  has_many :item_taggings
  has_many :items, through: :item_taggings
end
