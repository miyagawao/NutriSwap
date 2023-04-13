class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Contributor"
  belongs_to :comment
  
  validates :reason, presence: true, length: { maximum: 100 }
end
