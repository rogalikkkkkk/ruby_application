class CreateValues < ActiveRecord::Migration[7.1]
  def change
    create_table :values do |t|
      t.integer :user_id
      t.integer :image_id
      t.integer :value

      t.timestamps
    end
  end
end
