class RemoveColumnInspirationInActivity < ActiveRecord::Migration[5.2]
  def change
    remove_column :gallery_activities, :inspiration
  end
end
