require 'swagger_helper'
describe 'User API' do
  # initialize test data
  let(:user) {
    {
      email: 'test10@test.fr',
      password: 'azerty',
      password_confirmation: 'azerty'
    }
  }
  let(:created_user) { create(:user) }

  path '/users' do
    post 'Creates a User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema:
      {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email password password_confirmation]
      }

      response '201', 'user created' do
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) {
          {
            email: 'test1@test.fr',
            password: 'azerty',
            password_confirmation: 'qwerty'
          }
        }
        run_test!
      end
    end
  end

  path '/users/login' do
    post 'login User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, type: :object,
                properties: {
                  email: { type: :string },
                  password: { type: :string }
                }
      response '200', 'user login' do
        let(:user) {
          {
            email: created_user.email,
            password: created_user.password
          }
        }
        run_test!
      end

      response '401', 'user login' do
        let(:log_me) {
          {
            email: created_user.email,
            password: 'false password'
          }
        }
        run_test!
      end
      # end of login test
    end
  end
end
