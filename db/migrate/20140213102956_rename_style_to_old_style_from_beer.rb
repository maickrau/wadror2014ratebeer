class RenameStyleToOldStyleFromBeer < ActiveRecord::Migration
  def change
    rename_column :beers, :style, :old_style
  end
end
