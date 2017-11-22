class AddAliasToOrganizationsAndDepartments < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :alias, :string
    add_column :departments, :alias, :string
  end
end
