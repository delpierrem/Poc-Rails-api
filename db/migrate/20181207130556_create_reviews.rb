Sequel.migration do
  change do

    create_table :reviews do
      primary_key :id
      foreign_key :product_id, :products, index: true
      Integer :rate
      Text :comment
    end

  end
end
