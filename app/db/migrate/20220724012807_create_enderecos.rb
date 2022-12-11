class CreateEnderecos < ActiveRecord::Migration[7.0]
  def up
    if table_exists? :municipes
      create_table :enderecos do |t|
        t.string :cep, limit: 8, null: false
        t.string :longr, limit: 50, null: false
        t.string :complemento, limit: 50
        t.string :bairro, limit: 80, null: false
        t.string :cidade, limit: 30, null: false
        t.string :uf, limit: 2, null: false
        t.string :cdg_ibge, limit: 7
        t.integer :municipe_id, null: false, unique: true
        t.timestamps
      end
      add_foreign_key :enderecos, :municipes, column: :municipe_id if column_exists?(:enderecos, :municipe_id)
    end
  end

  def down
    drop_table :enderecos if table_exists? :enderecos
  end
end