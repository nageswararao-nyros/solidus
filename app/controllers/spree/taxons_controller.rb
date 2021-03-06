# frozen_string_literal: true

module Spree
  class TaxonsController < Spree::StoreController
    helper 'spree/products', 'spree/taxon_filters'

    before_action :load_taxon, only: [:show]

    respond_to :html

    def show
    
      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      respond_to do |format|
       format.js #-> when receiving a pure xml request, this will fire
       format.html
      end

    
      @products = @searcher.retrieve_products
      @taxonomies = Spree::Taxonomy.includes(root: :children)


      if params[:category]
        @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
        puts "nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn"
      
        @products = @searcher.retrieve_products
        @taxonomies = Spree::Taxonomy.includes(root: :children)
      end
    end

    private

    def load_taxon
      @taxon = Spree::Taxon.find_by!(permalink: params[:id])
    end

    def accurate_title
      if @taxon
        @taxon.seo_title
      else
        super
      end
    end
  end
end
