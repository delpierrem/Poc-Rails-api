Sequel.migration do
  change do
    add_column :products, :image_data, :json
  end
end
