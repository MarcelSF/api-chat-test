class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :session, foreign_key: true
      t.integer :identifier
      t.string :detected_language
      t.timestamps
    end
  end
end
