class Comment < ApplicationRecord
  belongs_to :contributor
  belongs_to :post
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id
  has_many :reports

  validates :comment_text, presence: true

end