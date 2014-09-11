require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  has_many :games, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  validates :email, :uniqueness => true,
                    :length => {:within => 5..50},
                    :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  before_save :encrypt_new_password
  
  def self.authenticate(email,password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end 
  
  def authenticated?(password)
    self.hashed_password ==encrypt(password)
  end
  
  protected 
    def encrypt_new_password
      return if password.blank?
      self.hashed_password = encrypt(password)
    end

    def password_required?
      hashed_password.blank? || password.present?
    end
    
    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
end
