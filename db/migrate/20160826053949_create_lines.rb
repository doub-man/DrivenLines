class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.string :name
      t.references :nation

      t.timestamps
    end
  end
end
