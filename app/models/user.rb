class User < Sequel::Model
  plugin :secure_password, include_validations: false
end
