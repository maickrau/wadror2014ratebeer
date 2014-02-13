class SelectNewStyleFromOldStyleInBeer < ActiveRecord::Migration
  def change
    Beer.all.each do |beer|
      beer.style = Style.select{ |style| style.name == beer.old_style }[0]
      beer.save!
    end
  end
end
