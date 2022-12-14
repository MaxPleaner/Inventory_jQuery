class Container < ApplicationRecord
  belongs_to :user
  before_update :cant_update_root
  before_destroy :cant_delete_root

  has_ancestry

  has_many :items

  validates :name, uniqueness: true, presence: true, allow_nil: false

  def cant_update_root
    name != "Root"
  end

  def cant_delete_root
    name != "Root"
  end
end
