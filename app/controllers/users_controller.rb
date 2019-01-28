class UsersController < ApplicationController
  def create
    render_json(User::Create.call(params))
  end

  def login
    render_json(User::Login.call(params))
  end
end
