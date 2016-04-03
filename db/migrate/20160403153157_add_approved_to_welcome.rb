class AddApprovedToWelcome < ActiveRecord::Migration
  def change
    add_column :welcomes, :approved, :integer
  end
end
