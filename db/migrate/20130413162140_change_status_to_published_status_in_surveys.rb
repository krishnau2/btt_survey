class ChangeStatusToPublishedStatusInSurveys < ActiveRecord::Migration
  def up
  	rename_column :surveys, :status, :published
  end

  def down
  	rename_column :surveys, :published, :status
  end
end
