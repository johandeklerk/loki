class CreateCustomAttributes < ActiveRecord::Migration
  def change
    create_table :custom_attributes do |t|
      t.string :name, :null => false
      t.string :value, :null => false
      t.references :attributable, :polymorphic => true
      t.timestamps
    end
    #add_index :custom_attributes, [:attributable_id, :attributable_type]
  end
end
