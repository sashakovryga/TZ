class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :type
      t.string :life_cycle

      t.timestamps
    end
  end
end
