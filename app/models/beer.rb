class Beer < ActiveRecord::Base
  include RatingAverage
  include BeerStyles

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, -> { uniq }, :through => :ratings, :source => :user

  validates :name, :presence => true
  validates :old_style, inclusion: {in: ["Weizen", "Lager", "Pale ale", "IPA", "Porter"], message: "%{value} is not a valid style"}

  def to_s
    "#{name}, #{brewery.name}"
  end

end
