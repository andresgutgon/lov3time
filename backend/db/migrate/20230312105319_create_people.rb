class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.date :birthday
      t.references(
        :user,
        null: false,
        foreign_key: { on_delete: :cascade },
        index: { unique: true }
      )

      t.timestamps
    end
  end
end
