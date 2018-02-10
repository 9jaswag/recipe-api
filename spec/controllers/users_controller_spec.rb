require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  let(:user) { build(:user) }

  # POST /signup
  describe 'POST /signup' do
    
    context 'when request is valid' do
      # make HTTP post request before each example
      before { post '/signup', params: user }

      it 'signs up a user and returns a response' do
        expect(json['jwt_token']).to exist
      end

      it 'returns a 201 status' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      # make HTTP post request before each example
      before { post '/signup', params: { username: 'chuks', email: 'chuks@email.com' } }

      it 'returns a validation error for missing field' do
        expect(response.body)
          .to match(/Validation failed: Password can't be blank/)
      end

      it 'returns a 422 status' do
        expect(response).to have_http_status(422)
      end
    end
  end

end
