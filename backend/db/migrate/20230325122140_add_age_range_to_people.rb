class AddAgeRangeToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :min_age, :integer, null: true
    add_column :people, :max_age, :integer, null: true
    add_column :people, :birthday_setup_at, :datetime, null: true
  end
end
