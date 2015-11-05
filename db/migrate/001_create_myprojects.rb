class CreateMyprojects < ActiveRecord::Migration
  def change
    create_table :my_projects do |t|
      t.references :user, null: false
      t.references :project, null: false
      t.timestamps null: false
    end
  end
end
