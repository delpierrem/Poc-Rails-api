class ReviewsController < ApplicationController
  def index
    result = Review::Index.call('product_id' => params[:product_id])
    render json: result['json']
  end

  # def show
  #   result = Review::Show.call('id' => params[:id])
  #   render json: result['json']
  # end
  #
  # def create
  #   result = Review::Create.call(params)
  #   if result.success?
  #     render json: ReviewRepresenter.prepare(result['model']),
  #     status: :created,
  #     location: product_path(result['model'].id)
  #   else
  #     render json: result['model']['errors'],
  #     status: :unprocessable_entity
  #   end
  # end
end
