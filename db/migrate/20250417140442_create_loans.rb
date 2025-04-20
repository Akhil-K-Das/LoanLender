class CreateLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :loans do |t|
      t.decimal :amount
      t.decimal :interest_rate
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.boolean :adjusted_by_admin, default: false

      t.timestamps
    end
  end
end
