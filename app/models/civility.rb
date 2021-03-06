class Civility < ActiveRecord::Base
  # Relationships
  has_many :user

  # Set accessible fields
  attr_accessible :name

  # API functions
  def to_builder
    Jbuilder.new do |civility|
      civility.(self, :name)
    end
  end
end
