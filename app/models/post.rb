class Post < ApplicationRecord
  belongs_to :contributor
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  belongs_to :genre

  validates :title, presence: true
  validates :content, presence: true
  
  attr_accessor :tag_list

  scope :search_genre, ->(genre) {where(genre_id: genre)}
  scope :search_tag, ->(tag_id) { joins(:post_tags).where(post_tags: { tag_id: tag_id }) }

  has_one_attached :image
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def save_tags(tag_list)
    tag_list.each do |new_name|
      tag = Tag.find_or_create_by(name: new_name.strip)
      self.tags << tag
    end
  end


  def self.search(search, word)
    if search == "forward_match"
      @post = Post.where("title LIKE ? OR body LIKE ?", "#{word}%", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE ? OR body LIKE ?", "%#{word}", "%#{word}%")
    elsif search == "perfect_match"
      @post = Post.where("title = ? OR body = ?", word, word)
    elsif search == "partial_match"
      @post = Post.where("title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%")
    end
  end
end