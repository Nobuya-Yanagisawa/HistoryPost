class Headline < ApplicationRecord
  belongs_to :post
  validates :headline_name, length: { maximum: 50 }
end
