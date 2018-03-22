require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  let!(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end
  before do
    @valid_header = {
      'Authorization' => JsonWebToken.encode(user_id: user.id),
      'Content-Type' => 'application/json'
    }

    @invalid_header = {
      'Authorization' => JsonWebToken.encode({ user_id: user.id }, (Time.now.to_i - 10)),
      'Content-Type' => 'application/json'
    }
  end

  # POST /signup
  describe 'POST /signup' do
    context 'when request is valid' do
      # make HTTP post request before each example
      before { post '/signup', params: valid_attributes.to_json, headers: @valid_header }

      it 'signs up a user and returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end

      it 'returns a 201 status' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      # make HTTP post request before each example
      before { post '/signup', params: {}, headers: @invalid_header }

      it 'returns a validation error' do
        expect(response.body)
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end

      it 'returns a 422 status' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
