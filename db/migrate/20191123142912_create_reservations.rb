class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :name, null: false, default: ''
      t.references :film, foreign_key: true
      t.string :email, null: false, default: ''
      t.string :document, null: false, default: ''
      t.string :phone, null: false, default: ''
      t.date :date, null: false, default: ''
      t.string :status, null: false, default: ''

      t.timestamps
    end
  end
end
