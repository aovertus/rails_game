class Game < ActiveRecord::Base
  validates_presence_of :title, :note
  validates_numericality_of :note, :greater_than_or_equal_to => 0, less_than_or_equal_to: 10
  has_many :comments
end
