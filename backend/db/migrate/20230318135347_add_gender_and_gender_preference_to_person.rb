class AddGenderAndGenderPreferenceToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :gender, :string, null: true
    add_column :people, :sexuality, :string, null: true
    add_column :people, :sexuality_visible, :boolean, null: false, default: true
    add_column :people, :gender_visible, :boolean, null: false, default: true
    add_column(
      :people,
      :gender_preference,
      :string,
      array: true,
      null: false,
      default: []
    )
  end
end
