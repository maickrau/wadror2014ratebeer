class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, :presence => true
  validates :year, :numericality => { greater_than_or_equal_to: 1042,
                                      only_integer: true}
  validate :year_is_not_in_the_future

  def year_is_not_in_the_future
    errors.add(:year, "must not be in the future") if year > Time.new.year
  end

end
