class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
<<<<<<< HEAD
=======

  before_create :generate_authentication_token!

  validates :auth_token, uniqueness:{case_sensitive: true}, allow_nil: true
  # generating auth token
  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
>>>>>>> a8994f5... 5.7 Destroy action sessions spec
end
