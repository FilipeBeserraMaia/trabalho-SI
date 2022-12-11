class CreateMunicipes < ActiveRecord::Migration[7.0]

  def up
    create_table :municipes do |t|
      t.string :nome, limit: 80, null: false
      t.string :cpf, limit: 11, null: false
      t.string :cns, limit: 15, null: false
      t.string :email, limit: 256, null: false
      t.date :dta_nasc, null: false
      t.string :telefone, limit: 13, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end

  def down
    drop_table :municipes if table_exists? :municipes
  end

end
