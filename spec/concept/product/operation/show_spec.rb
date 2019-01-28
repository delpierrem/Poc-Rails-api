require 'spec_helper'

RSpec.describe 'Product::Show' do
  let(:product) { create(:product) }

  it 'should return a product in json format' do
    result = Product::Show.call('id' => product.id)
    expect(result).to be_success
    expect(result['model'].values[:id]).to equal(product.id)
  end
  # TODO: create all action
  # it 'should return an error without id' do
  #   result = Product::Show.call()
  #   expect(result).to be_failure
  # end
end
