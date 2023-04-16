class Post < ApplicationRecord
  belongs_to :contributor
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true
  validates :content, presence: true

  attr_accessor :tag_list
  is_impressionable counter_cache: true

  enum status: {draft: 1,published: 0}


  has_one_attached :image
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def liked_by?(contributor)
    likes.where(contributor_id: contributor.id).exists?
  end

  def save_tags(tag_list)
    current_tags = self.tags.pluck(:name)
    new_tags = tag_list - current_tags # 更新後のタグのみを抽出
    old_tags = current_tags - tag_list # 削除するタグを抽出

    # 新しいタグを追加
    new_tags.each do |name|
      tag = Tag.find_or_create_by(name: name)
      self.tags << tag
    end

    # 削除するタグを削除
    old_tags.each do |name|
      tag = Tag.find_by(name: name)
      self.tags.delete(tag) if tag.present?
    end
  end

  scope :search_genre, ->(genre) {where(genre_id: genre)}
  scope :search_tag, ->(tag_id) { joins(:post_tags).where(post_tags: { tag_id: tag_id }) }

  def self.looks(search, word)
    if search == "partial_match"
      where("title LIKE ?", "%#{word}%")
    end
  end
end