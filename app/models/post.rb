class Post < ApplicationRecord
  # acts_as_taggable_on :tags
  belongs_to :contributor, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true

  scope :search_genre, ->(genre) {where(genre_id: genre)}

  has_one_attached :image
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

end
