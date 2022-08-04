class ItemTagging < ApplicationRecord
  belongs_to :item
  belongs_to :tag
end
