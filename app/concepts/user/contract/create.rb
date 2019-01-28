require 'dry/validation/compat/form'

module User::Contract
  class Create < Reform::Form
    include Dry

    property :email
    property :password
    property :password_confirmation, virtual: true
    validation do
      configure do
        config.messages_file = 'config/error_messages.yml'

        def unique?(value)
          User.find(email: value).nil? ? true : false
        end

        def email?(value)
          !/\A\S+@.+\.\S+\z/.match(value).nil?
        end
      end

      required(:email).filled(:unique?, :email?)
      required(:password).filled(min_size?: 6).confirmation
    end
  end
end
