# frozen_string_literal: true

require 'spec_helper'
RSpec.describe 'Rating API', type: :request do
  describe 'Create new Rating with POST request' do
    api = ClientApi::Api.new
    api.get('/login?username=admin&password=pass')
    token = api.body['token']
    user_id = api.body['data']['id']
    context 'with valid attribute values' do
      before do
        post = Post.first
        body = { 'rating': { 'rate': 3, 'user_id': user_id } }
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.post("/posts/#{post.id}/ratings/create", body, header)
      end

      it 'returns correct response' do
        expect(api.status).to eq(200)
        expect(api.body['data']['rate']).to eq(3)
      end
    end

    context 'with in-valid attribute values' do
      before do
        post = Post.first
        body = { 'rating': {} }
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.post("/posts/#{post.id}/ratings/create", body, header)
      end

      it 'returns error response' do
        expect(api.body['status']).to eq(422)
        expect(api.body['message']).to eq('Failed to create rating!')
      end
    end
  end
end
