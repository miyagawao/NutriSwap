class Contributor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :last_name, presence: true
         
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |contributor|
      contributor.password = SecureRandom.urlsafe_base64
      contributor.name = "guestuser"
    end
  end
  
end
