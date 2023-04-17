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
  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy

  validates :address, presence: true
  validates :comment_text, length: { maximum: 1000 }
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :first_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name, presence: true
  validates :last_name_kana, presence: true
  validates :nickname, presence: true
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
    find_or_create_by!(email: 'guest@example.com') do |contributor|
      contributor.password = SecureRandom.urlsafe_base64
      contributor.address = "東京都渋谷区道玄坂1-2-3"
      contributor.comment_text = "ゲストユーザーです"
      contributor.first_name = "ゲスト"
      contributor.first_name_kana = "ゲスト"
      contributor.last_name = "ユーザー"
      contributor.last_name_kana = "ユーザー"
      contributor.nickname = "ゲストユーザー"
      contributor.postal_code = "000-0000"
      contributor.telephone_number = "000-0000-0000"
      contributor.qualification = "ゲスト"
    end
  end

  def self.looks(search, word)
    if search == "partial_match"
      where("nickname LIKE ?", "%#{word}%")
    end
  end

end
