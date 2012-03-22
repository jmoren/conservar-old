class AddColumnToGenericTextField < ActiveRecord::Migration
  def self.up
    add_column :generic_text_fields, :generic_field_id, :integer
    add_column :generic_text_areas, :generic_field_id, :integer
    add_column :generic_integer_fields, :generic_field_id, :integer
    add_column :generic_boolean_fields, :generic_field_id, :integer
    add_column :generic_float_fields, :generic_field_id, :integer
  end

  def self.down
    remove_column :generic_text_fields, :generic_field_id
    remove_column :generic_text_areas, :generic_field_id
    remove_column :generic_integer_fields, :generic_field_id
    remove_column :generic_boolean_fields, :generic_field_id
    remove_column :generic_float_fields, :generic_field_id
  end
end
