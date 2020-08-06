class CreateLinkUses < ActiveRecord::Migration[6.0]
  def change
    create_table :link_uses do |t|
      t.datetime "created_at", precision: 6, null: false
      t.references :link, foreign_key: { on_delete: :cascade }, index: true, null: false
      t.text :user_agent
      t.text :identity
    end
  end
end
