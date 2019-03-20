class CreateHeadlines < ActiveRecord::Migration[5.2]
  def change
    create_table :headlines do |t|
      t.text :headline_name
      t.text :headline_content
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
