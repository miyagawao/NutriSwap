class Contributor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  
         
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |contributor|
      contributor.password = SecureRandom.urlsafe_base64
      contributor.name = "guestuser"
    end
  end
  
  def add_full_name
    "#{self.last_name} #{self.first_name}"
  end
  
  def get_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
end
