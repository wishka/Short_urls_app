class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original_url, null: false
      t.string :short_url, null: false, index: { unique: true }
      t.integer :clicks_count, default: 0

      t.timestamps
    end
  end
end
