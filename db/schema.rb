Sequel.migration do
  change do
    create_table(:products) do
      primary_key :id
      column :img_url, "text"
      column :title, "text"
      column :description, "text"
      column :price, "numeric"
      column :image_data, "json"
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:users) do
      primary_key :id
      column :email, "text"
      column :password_digest, "text", :null=>false
      
      index [:email], :name=>:users_email_key, :unique=>true
    end
    
    create_table(:reviews) do
      primary_key :id
      foreign_key :product_id, :products, :key=>[:id]
      column :rate, "integer"
      column :comment, "text"
      
      index [:product_id]
    end
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20181205141447_create_products.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20181207130556_create_reviews.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20181217125755_create_users.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20181228101111_add_images_data_to_products.rb')"
                end
              end
