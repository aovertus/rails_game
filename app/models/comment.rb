class Comment < ActiveRecord::Base
  validates :text, :length => { :maximum => 140 }
  belongs_to :game
end
