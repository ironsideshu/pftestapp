class AddRevToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :_rev, :string
  end
end
