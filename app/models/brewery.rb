class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, :presence => true
  validates :year, :numericality => { less_than_or_equal_to: 2014,
                                      greater_than_or_equal_to: 1042,
                                      only_integer: true}

end
