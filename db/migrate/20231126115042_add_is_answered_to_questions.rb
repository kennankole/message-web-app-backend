class AddIsAnsweredToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :is_answered, :boolean
  end
end
