require 'swagger_helper'

describe 'Product API', swagger_doc: 'api/swagger.json' do
  let!(:products) { create_list(:product, 10) }
  let(:id) { products.first.id }
  # Test for GET /products
  path '/products' do
    get 'Index todos' do
      parameter name: :per_page, :in => :query,
                :type => :integer, required: false
      parameter name: :page, :in => :query,
                :type => :integer, required: false
      tags 'Products'
      consumes 'application/json'
      response '200', 'success' do
        run_test! do
          expect(json).not_to be_empty
          expect(json['data'].size).to eq(10)
        end
      end
    end
  end

  path '/products/{id}' do
    get 'Get a product' do
      tags 'Products'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :integer
      response '200', 'Product found' do
        after do |example|
          example.metadata[:response][:examples] = {
            'application/json' => JSON.parse(
              response.body,
              symbolize_names: true
            )
          }
        end
        run_test!
      end

      response '404', 'not found' do
        after do |example|
          example.metadata[:response][:examples] = {
            'application/json' => JSON.parse(
              response.body,
              symbolize_names: true
            )
          }
        end
        let(:id) { 100 }
        run_test!
      end
    end
  end

  # Test for post /products
  path '/products' do
    post 'Creates a Product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema:
      {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          price: { type: :number },
          image: { type: :string }
        },
        required: %w[title content description price image]
      }

      response '201', 'product created' do
        let(:product) {
          {
            title: 'Macbook',
            description: 'Lorem ipsum dolor sit amet.',
            price: 1300.00,
            image: File.open('public/test/files/gg.png')
          }
        }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { title: 'foo' } }
        run_test!
      end
    end
  end
end
