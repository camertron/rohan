class AddTables < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :location
    end

    create_table :location do |t|
      t.string :branch_name
    end

    create_table :order_statuses do |t|
      t.references :order
      t.references :attendee, polymorphic: true
      t.references :till
    end

    create_table :managers do |t|
      t.string :username
    end

    create_table :merchant_staffs do |t|
      t.string :username
    end

    create_table :order_data do |t|
      t.references :order
      t.references :category
      t.references :discount_location_type
    end

    create_table :categories do |t|
      t.string :title
    end

    create_table :order_item_returns do |t|
      t.integer :order_datum_id
    end

    create_table :discount_location_types do |t|
    end

    create_table :tills do |t|
    end
  end
end
