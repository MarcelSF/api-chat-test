class AddTextToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :text, :string, default: ""
  end
end
