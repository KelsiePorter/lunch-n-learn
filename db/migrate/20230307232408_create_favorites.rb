class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :country
      t.string :recipe_link
      t.string :recipe_title
      t.string :user_api_key

      t.timestamps
    end

    add_index :favorites, :user_api_key 
  end
end
