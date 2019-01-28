Sequel.migration do
  change do

    create_table :products do
      primary_key :id
      String :img_url
      String :title
      Text :description
      Decimal :price
    end

  end
end
