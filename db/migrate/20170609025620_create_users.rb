class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true, :nill => false
      t.string :email,    unique: true, :nill => false
      t.string :password,               :nill => false
      t.string :password_confirmation,  :nill => false
      t.string :password_digest
      t.timestamps
    end
  end
end
