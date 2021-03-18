class RemoveIsActiveFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :is_active, :boolean
  end
end
