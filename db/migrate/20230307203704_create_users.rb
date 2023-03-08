class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :api_key, index: {unique: true}

      t.timestamps
    end
  end
end
