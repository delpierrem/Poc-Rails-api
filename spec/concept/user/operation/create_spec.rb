require 'spec_helper'

RSpec.describe 'User::Create' do
  let(:valid_params) {
    {
      user: {
        email: 'test@test.fr',
        password: 'azerty',
        password_confirmation: 'azerty'
      }
    }
  }

  let(:false_params) { { user: {} } }

  let(:false_psw) {
    {
      user: {
        email: 'test@test.fr',
        password: 'azertya',
        password_confirmation: 'azertyu'
      }
    }
  }

  it 'fails without params' do
    result = User::Create.call(false_params)
    expect(result).to be_failure
    expect(User.last).to be_nil
    expect(result['result.contract.default'].errors.messages)
      .to eq(
        email: ['must be filled', 'Already exists', 'Invalid format'],
        password: ['must be filled', 'size cannot be less than 6']
      )
  end

  it 'fails with different password_confirmation' do
    result = User::Create.call(false_psw)
    expect(result).to be_failure
    expect(User.last).to be_nil
    # TODO: change error message in user contract::create
    expect(result['result.contract.default'].errors.messages)
      .to eq(
        password_confirmation: ['must be equal to azertya']
      )
  end

  it 'should persit a User' do
    result = User::Create.call(valid_params)
    expect(result).to be_success
    expect(result['model'].email).to eq('test@test.fr')
    expect(User.last.email).to eq('test@test.fr')
  end
end
