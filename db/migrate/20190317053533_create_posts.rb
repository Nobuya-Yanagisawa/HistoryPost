class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
    	t.text :post_name
      t.text :introduction
      t.text :sub_title
      t.text :content
      t.text :post_image_id
      t.references :user, foreign_key: true

      t.timestamps
    end
      add_index :posts, [:user_id, :created_at]
  end
end
