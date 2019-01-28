module Api::V1::Product
  class Index < Trailblazer::Operation
    step :model!
    failure :out_of_range!
    success :for_json_api!

    def model!(options, params:, **)
      options['model'] = ::Product.all.paginate \
        page: params[:page],
        per_page: params[:per_page]
      out_of_range?(params[:page], options['model'])
    end

    def for_json_api!(options, params:, **)
      outcasts = params_to_sym_array(params[:exclude])
      options['json'] = Api::V1::Product::Representer::Show
                        .represent(options['model'])
                        .to_json(exclude: outcasts)
      options['status_code'] = :ok
    end

    def out_of_range!(options)
      options['json'] = {
        errors: {
          detail: 'Bad request',
          status: '400'
        }
      }.to_json
      options['status_code'] = :bad_request
    end
  end
end
# ( pages: {
#   current_page: options['model'].current_page,
#   next_page: options['model'].next_page,
#   previous_page: options['model'].previous_page,
#   total_pages: options['model'].total_pages
#   } )
