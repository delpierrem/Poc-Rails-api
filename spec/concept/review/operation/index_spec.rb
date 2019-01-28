require 'spec_helper'

RSpec.describe 'Product::Index' do
  let!(:product) { create(:product) }
  let!(:review_lists) { create_list(:review, 20, product_id: product.id) }

  it 'shouds index products' do
    result = Review::Index.call('product_id' => product.id)
    expect(result).to be_success
    expect(result['model'].length).to equal(20)
  end
end
