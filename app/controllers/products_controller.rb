class ProductsController < ApplicationController
  def index
    result = Product::Index.call(params)
    render json: result['json']
  end

  def show
    result = Product::Show.call('id' => params[:id])
    if result.success?
      render json: result['json']
    elsif result['model'].nil?
      render json: result['json'], status: :not_found
    end
  end

  def create
    result = Product::Create.call(params)
    if result.success?
      render json: result['json'], status: :created,
             location: product_path(result['model'].id)
    else
      render json: result['contract.default'].errors,
             status: :unprocessable_entity
    end
  end
end
