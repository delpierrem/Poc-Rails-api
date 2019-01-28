require 'spec_helper'

RSpec.describe 'Api::V1::Product::Create' do
  let(:valid_params) {
    {
      product: {
        title: 'Macbook',
        description: 'a product description ',
        price: 122.50,
        image: File.open('public/test/files/gg.png')
      }
    }
  }

  let(:false_params) { { product: {} } }

  it 'fails without params' do
    result = Api::V1::Product::Create.call(false_params)
    expect(result).to be_failure
    expect(Product.last).to be_nil
    expect(result['result.contract.default'].errors.messages)
      .to eq(
        title: ["can't be blank"],
        description: ["can't be blank"],
        price: ["can't be blank"]
      )
  end

  it 'should persit a Product' do
    result = Api::V1::Product::Create.call(valid_params)
    expect(result).to be_success
    expect(result['model'].title).to eq('Macbook')
    # puts "_______#{result['model'].image}//<==="
  end
end
