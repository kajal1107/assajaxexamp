class AddFieldToUser < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :u_address, :string 
  	add_column :users, :town, :string
  	add_column :users, :area, :string
  	add_column :users, :country, :string
  	add_column :users, :postal_code, :integer
  end
end
