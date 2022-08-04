class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :container, null: false, foreign_key: true
      t.string :name
      t.text :details

      t.timestamps
    end
  end
end
