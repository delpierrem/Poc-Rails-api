class Product::Index < Trailblazer::Operation
  step :model!
  failure :out_of_range!
  success :for_json_api!

  def model!(options, params:, **)
    options['model'] = ::Product.all.paginate \
      page: params[:page],
      per_page: params[:per_page]
    params[:page].to_i <= options['model'].total_pages # if false > out_of_range
  end

  def for_json_api!(options, *)
    options['json'] = ProductRepresenter.represent(options['model'])
                                        .to_json(included: false)
  end

  def out_of_range!(options)
    options['json'] = {
      errors: {
        detail: 'out of range',
        status: '416'
      }
    }.to_json
  end
end
