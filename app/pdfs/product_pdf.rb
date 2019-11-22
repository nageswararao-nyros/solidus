class ProductPdf < Prawn::Document
	def initialize(products)
		super()
		@products = products
     	heading
     	product_list
	end

	def heading
		text "Products List", size: 30, style: :bold
	end

	def product_list
		move_down 20
		table product_list_rows do
			row(0).font_style = :bold
		end
	end

	def product_list
		move_down 20
		table product_list_rows do
			row(0).font_style = :bold
		end
	end

	def product_list_rows
		
		[[ "Id", "name", "Unit Price", "Category", "Brand"]] + 
		@products.map do |product|
	    [product.id, product.name, product.price, product.taxons.map(&:name).first, product.taxons.map(&:name).second]    
		end
  end
	
end