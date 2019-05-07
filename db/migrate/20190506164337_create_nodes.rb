class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |n|
      n.string :content, null: false, default: "Default content"
      n.integer :node_id, null: false
      n.integer :left, default: nil
      n.integer :right, default: nil
      n.integer :parent, default: nil
    end
  end
end
