class RemoveIndexImplementation < ActiveRecord::Migration[5.2]
  def change
    remove_index "experience_implementations", name: "experience_implementation_index"
  end
end
