require 'digest'

class User < ActiveRecord::Base 
  
  attr_accessor :password
  has_many :player_one, :class_name => 'Match', :foreign_key => 'player_one_id'
  has_many :player_two, :class_name => 'Match', :foreign_key => 'player_two_id'
  has_many :tournaments
  has_many :games, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  has_many :tournament_players
  has_many :tournaments, through: :tournament_players
  validates :email, :uniqueness => true,
                    :length => {:within => 5..50},
                    :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  before_save :encrypt_new_password
  #after_create :sign_up_mail
  
  
  def score(tournament)
    score = tournament.matches.where(player_one_id: self.id).sum(:score_one) + tournament.matches.where(player_two_id: self.id).sum(:score_two)

  end
  
  def self.authenticate(email,password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end 
  
  def authenticated?(password)
    self.hashed_password ==encrypt(password)
  end
  
  

  def self.from_omniauth(auth)
    where(provider: auth.provider).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
      user.save!
    end
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
    
    def sign_up_mail
      Notifier.sign_up_mail(self).deliver
    end
end
