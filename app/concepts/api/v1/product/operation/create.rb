module Api::V1::Product
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Product, :new)
      step Contract::Build(constant: Api::V1::Product::Contrat::Create)
    end

    step Nested(Present)
    step Contract::Validate(key: :product)
    failure :validation_error!
    step Contract::Persist()
    success :for_json_api!

    def for_json_api!(options, *)
      options['json'] = ProductRepresenter.represent(options['model'])
                                          .to_json(included: false)
      options['status_code'] = :created
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
