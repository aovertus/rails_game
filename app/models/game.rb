class Game < ActiveRecord::Base
  validates_presence_of :title, :note
  validates_numericality_of :note, :greater_than_or_equal_to => 0, less_than_or_equal_to: 10
  has_many :comments, :dependent => :nullify
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  def owned_by?(owner)
    return false unless owner.is_a? User
    owner == user
  end
end
