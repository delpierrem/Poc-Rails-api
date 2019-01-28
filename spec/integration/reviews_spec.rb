require 'swagger_helper'

describe 'Items API' do
  # initialize test data
  let(:product) { create(:product) }
  let(:product_id) { product.id }
  let!(:reviews) { create_list(:review, 20, product_id: product_id) }
  let(:id) { reviews.first.id }

  # Test for GET /products/id/reviews
  path '/products/{product_id}/reviews' do
    get 'Index product reviews' do
      tags 'Reviews'
      consumes 'application/json'
      parameter name: :product_id, :in => :path, :type => :integer
      response '200', 'reviews lists found' do
        run_test! do |response|
          # expect(json).not_to be_empty
          # expect(json["data"].size).to eq(20)
        end
      end
    end
  end
end
