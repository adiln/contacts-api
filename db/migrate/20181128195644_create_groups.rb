class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string  :name
      t.integer :user_id
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
