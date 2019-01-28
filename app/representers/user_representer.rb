require 'roar/json/json_api'

class UserRepresenter < Roar::Decorator
  include Roar::JSON::JSONAPI.resource :users
  # resource object links

  BASE_URL = 'http://localhost:3000/users'

  link(:self) { "#{base_url}/users/#{represented.id}" }

  attributes do
    property :email
  end
end
