# This migration comes from solidus_slider (originally 20160214061128)
class AddShowCaptionToSlides < SolidusSupport::Migration[4.2]
  def change
    add_column :spree_slides, :show_caption, :boolean
  end
end
