class CreateDisbursements < ActiveRecord::Migration[6.1]
  def change
    create_table :disbursements do |t|
      t.references :merchant, null: false, foreign_key: true
      t.decimal :amount, null: false, precision: 16, scale: 2, default: 0
      t.date :date, null: false
      
      t.timestamps
    end
  end
end
