class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :token, null: false, unique: true
      t.boolean :admin, null: false
      t.boolean :disabled, null: false
      t.timestamps
    end
  end
end
