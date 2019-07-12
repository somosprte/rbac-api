# frozen_string_literal: true

# This migration comes from experience (originally 20190614135227)
class RemoveIndexImplementation < ActiveRecord::Migration[5.2]
  def change
    remove_index 'experience_implementations', name: 'experience_implementation_index'
  end
end
