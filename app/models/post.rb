class Post < ApplicationRecord
	attachment :post_image, content_type: ["image/jpeg", "image/png", "image/gif"]

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  scope :search_by_keyword, -> (keyword) {
    where("posts.post_name LIKE :keyword", keyword: "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
  validates :user_id, 	presence: true
  validates :post_name, presence: true, length: { maximum: 50 }
  validates :sub_title, presence: true, length: { maximum: 50 }
  validates :content, 	presence: true

	has_many :headlines, dependent: :destroy, inverse_of: :post
	accepts_nested_attributes_for :headlines, reject_if: :all_blank, allow_destroy: true

	has_many :likes, dependent: :destroy
	has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

	# 投稿をいいねする
  def like(user)
    likes.create(user_id: user.id)
  end

  # 投稿のいいねを解除する
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  # 現在のユーザーがいいねしている場合にtrueを返す
  def like?(user)
    like_users.include?(user)
  end
end
