class User::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Create)
  end
  step Nested(Present)
  step Contract::Validate(key: :user)
  step Contract::Persist()
  success :for_json_api!
  failure :log_error!

  def for_json_api!(options, *)
    options['json'] = UserRepresenter.represent(options['model']).to_json
    options['status_code'] = :created
  end

  def log_error!(options)
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
