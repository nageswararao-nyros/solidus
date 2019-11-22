# This migration comes from solidus_slider (originally 20150611113500)
class CreateSliderLocation < SolidusSupport::Migration[4.2]
  def change
    create_table :spree_slide_locations do |t|
      t.string :name
      t.timestamps
    end
  end
end