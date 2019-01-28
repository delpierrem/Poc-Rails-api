require 'spec_helper'

RSpec.describe 'Product::Index' do
  let!(:products) { create_list(:product, 40) }

  it 'shouds index products with default pagination' do
    result = Product::Index.call
    expect(result).to be_success
    expect(result['model'].length).to equal(30)
  end

  it 'shouds index products with given per_page params' do
    result = Product::Index.call(per_page: 5)
    expect(result).to be_success
    expect(result['model'].length).to equal(5)
  end

  it 'shouds index second page products' do
    result = Product::Index.call(page: 2)
    expect(result).to be_success
    expect(result['model'].length).to equal(10)
  end
end
