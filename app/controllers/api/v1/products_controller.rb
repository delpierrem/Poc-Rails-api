module Api::V1
  class ProductsController < ApplicationController
    def index
      render_json(Api::V1::Product::Index.call(params))
    end

    def show
      render_json(Api::V1::Product::Show.call(params))
    end

    def create
      render_json(Api::V1::Product::Create.call(params))
    end

    def upload_image
      p "#{params} from CTRL"
      render_json(Api::V1::Product::UploadImage.call(params))
    end
  end
end
