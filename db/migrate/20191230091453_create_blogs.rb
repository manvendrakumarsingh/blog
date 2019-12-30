class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
