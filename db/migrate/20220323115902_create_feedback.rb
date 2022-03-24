class CreateFeedback < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.string :comment, null: false
      t.bigint :owner_id, null: false
      t.references :user, index: true
      t.references :post, index: true
      t.timestamps
    end
  end
end
