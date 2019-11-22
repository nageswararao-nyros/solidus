class Users < ActiveRecord::Migration[5.2]
  def change
  	 add_column :spree_users, :provider, :string
  	  add_column :spree_users, :uid, :string
  	   add_column :spree_users, :token, :string
  	    add_column :spree_users, :expires_at, :integer
  	      add_column :spree_users, :expires, :boolean
  	      add_column :spree_users, :refresh_token, :string
  	    


  end
end


