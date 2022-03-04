class AddUserIdToArticles < ActiveRecord::Migration[5.1]
  def up
    # https://edgeguides.rubyonrails.org/active_record_migrations.html
    add_reference :articles, :user, foreign_key: true
  end

  def down
    # remove_column :articles, :user_id, :integer
  end
end
