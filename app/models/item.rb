class Item < ApplicationRecord
  validate :name, uniqueness: true, presence: true

  belongs_to :container
  belongs_to :user, through: :container
end
