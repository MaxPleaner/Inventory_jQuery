class CreateItemTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :item_taggings do |t|
      t.references :item, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
