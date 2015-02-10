class CreateRate < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.belongs_to :school
      t.string :code
      # note:  I did not test these defaults
      t.string :name, default: ''
      t.string :group, default: ''
      t.string :status, default: ''
      t.string :description, default: ''
      t.float :percent, default: 0.0
      t.integer :num, default: 0
    end
  end
end
