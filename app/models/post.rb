class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, 	presence: true
  validates :post_name, presence: true, length: { maximum: 50 }
  validates :sub_title, presence: true, length: { maximum: 50 }
  validates :content, 	presence: true
end
