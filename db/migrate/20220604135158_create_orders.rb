class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :merchant, null: false, foreign_key: true
      t.references :shopper, null: false, foreign_key: true
      t.decimal :amount, null: false, precision: 16, scale: 2, default: 0
      t.datetime :completed_at

      t.timestamps
    end
  end
end
