class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports, id: false do |t|
      t.binary :id, limit: 16, primary_key: true

      t.string :url

      t.timestamps
    end
    add_index :reports, :url, unique: true
  end
end
