class AddRecommendToWelcome < ActiveRecord::Migration
  def change
    add_column :welcomes, :recommend, :integer
  end
end
