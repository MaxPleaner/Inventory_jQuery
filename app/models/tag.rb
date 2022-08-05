class Tag < ApplicationRecord
  has_many :item_taggings
  has_many :items, through: :item_taggings

  validates :name, presence: true, uniqueness: true
end
