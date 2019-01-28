class Product::Show < Trailblazer::Operation
  step :model!
  failure :not_found!
  success :for_json_api!

  def model!(options, params:, **)
    options['model'] = Product.find(id: params['id'])
  end

  def for_json_api!(options, *)
    options['json'] = ProductRepresenter.represent(options['model'])
                                        .to_json # add (included: false)
  end

  def not_found!(options)
    options['json'] = {
      errors: {
        detail: 'not_found',
        status: '404'
      }
    }.to_json
  end
end
