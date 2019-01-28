# require 'rails_helper'
#
# RSpec.describe 'POST /products' do
#   context 'with valid parameters' do
#     let(:valid_params) do
#       {
#         product: {
#           title: 'Fake Place',
#           description: 'a product description ',
#           price: 122.50,
#           image: File.open("public/test/files/gg.png")
#         }
#       }
#     end
#
#     it 'creates a new product' do
#       expect { post '/products', params: valid_params }
#         .to change(Product, :count).by(+1)
#       expect(response).to have_http_status :created
#     end
#   end
# end
