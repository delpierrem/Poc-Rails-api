require 'swagger_helper'

describe 'Product API', swagger_doc: 'v1/swagger.json' do
  let!(:products) { create_list(:product, 10) }
  let(:id) { products.first.id }
  path '/api/v1/products' do
    get 'Index todos' do
      tags 'API V1 Product'
      parameter name: :per_page, :in => :query,
      :type => :integer, required: false,
      description: 'default: 30'
      parameter name: :page, :in => :query,
      :type => :integer, required: false,
      description: 'default: 1'
      parameter name: :exclude,
      :in => :query,
      :type => :array,
      items: {
        type: 'string',
        enum: %w[reviews]
      },
      required: false,
      description: 'exclude nested ressources'
      tags 'API V1 Product'
      consumes 'application/json'
      response '200', 'success' do
        let(:page) { 1 }
        run_test! do
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end
      response '400', 'Bad Request' do
        after do |example|
          example.metadata[:response][:examples] = {
            'application/json' => JSON.parse(
              response.body,
              symbolize_names: true
            )
          }
        end
        let(:page) { 100 }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do
    get 'Get a product' do
      tags 'API V1 Product'
      produces 'application/json'
      parameter name: :id, :in => :path, type: :integer
      parameter name: :exclude,
      :in => :query,
      :type => :array,
      items: {
        type: 'string',
        enum: %w[reviews]
      },
      required: false,
      description: 'exclude nested ressources'
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

  # Test for post a product
  path '/api/v1/products' do
    post 'Creates a Product' do
      tags 'API V1 Product'
      consumes 'application/json'
      parameter name: :product, in: :body, schema:
      {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          price: { type: :number }
        },
        required: %w[title content description price]
      }
      response '201', 'product created' do
        let(:product) do
          {
            title: 'Macbook',
            description: 'Lorem ipsum dolor sit amet.',
            price: 1300.00
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}/upload_image' do
    parameter name: :id, in: :path, type: :string
    post 'Upload an image' do
      tags 'API V1 Product'
      consumes 'application/json'
      parameter name: :product, in: :body, schema:
      {
        type: :object,
        properties: {
          image: { type: :string }
        },
        required: %w[title content description price]
      }

      response '200', 'product created' do
        let(:product) { {image: File.open('public/test/files/gg.png') } }
        run_test!
      end

      # response '422', 'invalid request' do
      #   let(:product) { { title: 'foo' } }
      #   run_test!
      # end
    end
  end
end
