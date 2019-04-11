class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.text :comment_content
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
