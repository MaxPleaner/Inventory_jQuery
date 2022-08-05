class Item < ApplicationRecord
  validates :name, presence: true

  belongs_to :container
  has_one :user, through: :container

  has_many :item_taggings
  has_many :tags, through: :item_taggings
end
