class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :code
      t.string :address
      t.float :lat
      t.float :long
    end
  end
end
