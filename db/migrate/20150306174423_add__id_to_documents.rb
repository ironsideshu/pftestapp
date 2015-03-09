class AddIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :_id, :string
  end
end
