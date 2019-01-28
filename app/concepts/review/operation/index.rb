class Review::Index < Trailblazer::Operation
  step :model!
  success :for_json_api!

  def model!(options, params:, **)
    product = Product.find(id: params['product_id'])
    options['model'] = product.reviews
  end

  def for_json_api!(options, *)
    options['json'] = ReviewRepresenter.represent(options['model']).to_json
  end
end
