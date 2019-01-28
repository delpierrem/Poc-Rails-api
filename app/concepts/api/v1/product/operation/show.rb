module Api::V1::Product
  class Show < Trailblazer::Operation
    step :model!
    failure :not_found!
    step :for_json_api!

    def model!(options, params:, **)
      options['model'] = Product.find(id: params[:id])
    end

    def for_json_api!(options, params:, **)
      outcasts = params_to_sym_array(params[:exclude])
      options['json'] = Api::V1::Product::Representer::Show
                        .represent(options['model'])
                        .to_json(exclude: outcasts)
      options['status_code'] = :ok
    end

    def not_found!(options)
      options['json'] = {
        errors: {
          detail: 'not_found',
          status: '404'
        }
      }.to_json
      options['status_code'] = :not_found
    end
  end
end
