require 'spec_helper'

RSpec.describe 'User::Create' do
  let!(:user) { create(:user) }
  let!(:valid_params) { { email: user.email, password: 'azerty' } }

  # it 'fails without params' do
  #   result = User::Create.call(false_params)
  #   expect(result).to be_failure
  #   expect(User.last).to be_nil
  #   expect(result['result.contract.default'].errors.messages)
  #   .to eq(
  #     email: ['must be filled'],
  #     password: ['must be filled', 'size cannot be less than 6']
  #   )
  # end

  it 'should Login a User' do
    result = User::Login.call(valid_params)
    expect(result).to be_success
    expect(result['model'].email).to eq(user.email)
  end
end
