class CreateModels < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :username, null: false
			t.string :email, null: false
			t.string :password_salt, null: false
			t.string :password_hash, null: false
			t.timestamps
		end

		create_table :invitations do |t|
			t.references :user, null: false
			t.string :code, null: false
			t.datetime :accepted_at, null: true
			t.timestamps
		end

		create_table :projects do |t|
			t.references :owner, null: false
			t.string :name, null: false
			t.timestamps
		end

		create_table :project_grants do |t|
			t.references :project, null: false
			t.references :user, null: false
			t.datetime :accepted_at, null: true
			t.datetime :declined_at, null: true
			t.timestamps
		end

		create_table :targets do |t|
			t.references :user, null: false
			t.references :project, null: false
			t.string :url, null: true
			t.boolean :active, default: 0, null: false
			t.timestamps
		end
	end
end
