class CreateRoomTags < ActiveRecord::Migration[6.0]
  def change
    create_table :room_tags do |t|
      t.references :room, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    add_index :room_tags, [:room_id, :tag_id], unique: true
  end
end
