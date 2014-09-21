class Tournament < ActiveRecord::Base
  belongs_to :user
  has_many :tournament_players
  has_many :tournament_games
  has_many :users, through: :tournament_players
  has_many :games, through: :tournament_games
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  accepts_nested_attributes_for :games

  validates_presence_of :name, :address
  validates_date :start_at, :on_or_after => lambda { Date.current }
  validates_date :end_at, :on_or_after => lambda { :start_at }
  
  def can_subscribe?(tournament, user)
    if tournament.users.count < tournament.max_player && !tournament.users.exists?(user) && tournament.user != user 
       true
    else
      false
    end
  end 
  
  def is_admin?(tournament, user)
    true if tournament.user == user
  end
end
