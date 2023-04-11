class Like < ApplicationRecord
  belongs_to :contributor
  belongs_to :post
end
