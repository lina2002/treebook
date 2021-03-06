class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  has_many :statuses

  validates :first_name, presence: true

  validates :last_name, presence: true

  attr_accessor :login

  def self.find_for_database_authentication(warden_conditions)
  	conditions = warden_conditions.dup
    if login = conditions.delete(:login)
    	where(conditions.to_hash).where(["lower(profile_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
    	where(conditions.to_hash).first
    end
  end

  validates :profile_name,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

end
