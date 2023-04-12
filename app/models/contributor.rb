class Contributor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Deviseの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :address, presence: true
  validates :comment_text, presence: true, length: { maximum: 1000 }
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :first_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name, presence: true
  validates :last_name_kana, presence: true
  validates :postal_code, presence: true
  validates :telephone_number, presence: true

  def add_full_name
    "#{last_name} #{first_name}"
  end

  def get_image
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end

  def profile_image?
    profile_image.attached?
  end

  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |contributor|
      contributor.password = SecureRandom.urlsafe_base64
      contributor.name = "guestuser"
    end
  end

  def self.looks(search, word)
    if search == "partial_match"
      where("nickname LIKE ?", "%#{word}%")
    end
  end

end
