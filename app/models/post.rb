class Post < ApplicationRecord
  belongs_to :contributor
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  belongs_to :genre

  validates :title, presence: true
  validates :content, presence: true
  
  attr_accessor :tag_list

  scope :search_genre, ->(genre) {where(genre_id: genre)}

  has_one_attached :image
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def save_tags(tag_list)
    self.tags = tag_list.map do |tag|
      Tag.where(name: tag.strip).first_or_create!
    end
  end
end