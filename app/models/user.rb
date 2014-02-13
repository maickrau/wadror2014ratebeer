class User < ActiveRecord::Base
  include RatingAverage
  include BeerStyles

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
  validate :password_is_not_completely_stupid

  has_many :memberships, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  has_many :beer_clubs, :through => :memberships

  def password_is_not_completely_stupid
    return if password.nil?
    errors.add(:password, 'must contain an upper case letter') if password == password.downcase
    errors.add(:password, 'must contain a lower case letter')  if password == password.upcase
    errors.add(:password, 'must contain a number') if not password =~ /\d/
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    Style.select{|style| not style_average(style).nil? }.max_by{ |style| style_average(style) }
  end

  def style_average(style)
    de_NaN_ify average_of_list(ratings.select{ |rating| rating.beer.style == style })
  end

  def favorite_brewery
    Brewery.select{|brewery| not brewery_average(brewery).nil? }.max_by{ |brewery| brewery_average(brewery) }
  end

  def brewery_average(brewery)
    de_NaN_ify average_of_list(ratings.select{ |rating| rating.beer.brewery == brewery })
  end

  def de_NaN_ify(maybe_nan)
    maybe_nan.nan? ? nil : maybe_nan
  end
end
