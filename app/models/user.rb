class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
  validate :password_is_not_completely_stupid, on: :create, on: :update

  has_many :memberships, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  has_many :beer_clubs, :through => :memberships

  def password_is_not_completely_stupid
    errors.add(:password, 'must contain an upper case letter') if password == password.downcase
    errors.add(:password, 'must contain a lower case letter')  if password == password.upcase
    errors.add(:password, 'must contain a number') if not password =~ /\d/
  end

end
