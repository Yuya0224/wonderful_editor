class AddStateToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :state, :integer
  end
end
