require 'spec_helper'
RSpec.describe 'Api::V1::Product::UploadImage' do
  let(:product) { create(:product_without_image) }
  let(:valid_params) {
    {
      image: File.open('public/test/files/gg.png')
    }
  }

  it 'should upload an image' do
    result = Api::V1::Product::UploadImage
             .call(id: product.id, product: valid_params)
    expect(result).to be_success
    puts "#{result['model'].inspect}<========="
    expect(result['model'].image.metadata['filename']).to eq('gg.png')
  end

  it 'should validate presence of  image' do
    result = Api::V1::Product::UploadImage
             .call(id: product.id, product: {})
    expect(result).to be_failure
    expect(result['result.contract.default'].errors.messages)
      .to eq(image: ["can't be blank"])
  end
end
