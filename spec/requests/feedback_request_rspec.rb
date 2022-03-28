# frozen_string_literal: true

require 'spec_helper'
RSpec.describe 'Feedback API', type: :request do
  describe 'Create new Feedback with POST request' do
    api = ClientApi::Api.new
    api.get('/login?username=admin&password=pass')
    token = api.body['token']
    user_id = api.body['data']['id']
    context 'with valid attribute values' do
      before do
        post = Post.first
        body = { 'feedback': { 'comment': 'test', 'user_id': user_id } }
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.post("/posts/#{post.id}/feedbacks/create", body, header)
      end

      it 'returns correct response' do
        expect(api.status).to eq(200)
        expect(api.body['data']['comment']).to eq('test')
      end
    end

    context 'with in-valid attribute values' do
      before do
        post = Post.first
        body = { 'feedback': {} }
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.post("/posts/#{post.id}/feedbacks/create", body, header)
      end

      it 'returns error response' do
        expect(api.body['status']).to eq(422)
        expect(api.body['message']).to eq('Failed to create feedback!')
      end
    end
  end
end
