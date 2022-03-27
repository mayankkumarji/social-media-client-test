class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.string :auther_ip
      t.references :user, index: true
      t.timestamps
    end
  end
end
