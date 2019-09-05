class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.references :session, foreign_key: true
      t.string :message, null: false, default: ""
      t.string :locale_key
      t.string :reply_to
      t.timestamps
    end
  end
end
