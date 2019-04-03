class Headline < ApplicationRecord
  belongs_to :post
  validates :sub_title, length: { maximum: 50 }
end
