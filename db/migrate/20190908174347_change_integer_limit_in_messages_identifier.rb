class ChangeIntegerLimitInMessagesIdentifier < ActiveRecord::Migration[5.2]
  def change
     change_column :messages, :identifier, :integer, limit: 8
  end
end
