# frozen_string_literal: true

require 'spec_helper'
RSpec.describe 'User authentication', type: :request do
  describe 'POST /login' do
    api = ClientApi::Api.new
    context 'with valid attribute values' do
      before do
        body = { username: 'admin', password: 'pass' }
        api.post('/login', body)
      end

      it 'returns correct response' do
        expect(api.status).to eq(200)
        expect(api.body['data']['username']).to eq('admin')
        expect(api.body['data']['password']).to eq('pass')
      end
    end

    context 'with in-valid attribute values' do
      before do
        body = { username: 'admin', password: nil }
        api.post('/login', body)
      end

      it 'returns error response' do
        expect(api.body['status']).to eq(404)
        expect(api.body['message']).to eq('Login failed!')
      end
    end
  end
end
