class User < ApplicationRecord
  has_many :containers
  has_many :items, through: :containers
  has_one :root_container, -> { where(name: "Root") }, class_name: "Container"

  after_create :create_root_container

  def create_root_container
    containers.create!(name: "Root")
  end
end
