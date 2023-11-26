class RemoveCustomerAndAgentAddUsersIDentityToUsers < ActiveRecord::Migration[7.0]
  def change
  end
  def change
    remove_column :users, :customer_user_id, :string
    remove_column :users, :agent_user_id, :string

    add_column :users, :user_identity, :string
  end
end
