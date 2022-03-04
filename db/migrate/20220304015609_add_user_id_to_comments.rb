class AddUserIdToComments < ActiveRecord::Migration[5.1]
  def change
    # https://edgeguides.rubyonrails.org/active_record_migrations.html
    add_reference :comments, :user, foreign_key: true
  end
end
