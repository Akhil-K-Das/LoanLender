class CreateLoanAdjustments < ActiveRecord::Migration[7.2]
  def change
    create_table :loan_adjustments do |t|
      t.references :loan, null: false, foreign_key: true
      t.decimal :new_amount
      t.decimal :new_interest_rate
      t.string :made_by

      t.timestamps
    end
  end
end
