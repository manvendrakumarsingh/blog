class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true
      t.text :comment_reply

      t.timestamps
    end
  end
end
