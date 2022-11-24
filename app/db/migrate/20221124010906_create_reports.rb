class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :url

      t.timestamps
    end
    add_index :reports, :url, unique: true
  end
end
