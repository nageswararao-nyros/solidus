class UserPdf < Prawn::Document
	def initialize(users)
		super()
		@users = users
     	heading
     	user_list
	end

	def heading
		text "Registered Users List", size: 30, style: :bold
	end

	def user_list
		move_down 20
		table user_list_rows do
			row(0).font_style = :bold
		end
	end

	def user_list
		move_down 20
		table user_list_rows do
			row(0).font_style = :bold
		end
	end

	def user_list_rows

		[[ "Id", "Email", "Orders","Sign_in_count"]] + 
		@users.map do |user|
			[user.id, user.email, user.order_count, user.sign_in_count]
		end
  end
	
end