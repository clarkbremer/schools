class CreateRate < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.belongs_to :school
      t.string :code
      t.string :name
      t.string :group
      t.string :status
      t.string :desc
      t.float :percent
      t.integer :num
    end
  end
end
