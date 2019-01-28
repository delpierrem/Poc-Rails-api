module Api::V1::Product
  class UploadImage < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step :model!
      step Contract::Build(constant: Api::V1::Product::Contrat::UploadImage)
      
      def model!(options, params:, **)
        options['model'] = Product.find(id: params[:id])
      end
    end

    step Nested(Present)
    step Contract::Validate(key: :product)
    failure :validation_error!
    step Contract::Persist()
    success :for_json_api!

    def for_json_api!(options, *)
      options['json'] = Api::V1::Product::Representer::Show
                        .represent(options['model'])
                        .to_json(included: false)
      options['status_code'] = :ok
    end

    def validation_error!(options)
      options['json'] = {
        errors: {
          detail: 'invalid request',
          status: '422',
          sources: options['contract.default'].errors
        }
      }.to_json
      options['status_code'] = :unprocessable_entity
    end
  end
end
