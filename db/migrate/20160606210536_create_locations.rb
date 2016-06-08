class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|

      t.belongs_to :user, index:true
      	
      t.string :postal_code
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
