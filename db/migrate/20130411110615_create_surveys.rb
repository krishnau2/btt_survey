class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.text :description
      t.date :published_on
      t.boolean :status, :default => false

      t.timestamps
    end
  end
end
