class Tag < ApplicationRecord
  has_many :item_taggings
  has_many :items, through: :item_taggings
  belongs_to :user

  validates :name, presence: true, uniqueness: true
end
