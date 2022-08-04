class Item < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  belongs_to :container
  has_one :user, through: :container
end
