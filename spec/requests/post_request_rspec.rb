# frozen_string_literal: true

require 'spec_helper'
RSpec.describe 'Post API', type: :request do
  describe 'Create new Post with POST request' do
    api = ClientApi::Api.new
    api.get('/login?username=admin&password=pass')
    token = api.body['token']
    user_id = api.body['data']['id']
    context 'with valid attribute values' do
      before do
        body = { 'posts': { 'title': 'aa', 'content': 'cc', 'user_id': user_id } }
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.post('/posts/create', body, header)
      end

      it 'returns correct response' do
        expect(api.status).to eq(200)
        expect(api.body['data']['title']).to eq('aa')
        expect(api.body['data']['content']).to eq('cc')
      end
    end

    context 'with new auther' do
      before do
        body = { 'posts': { 'title': 'aa', 'content': 'cc', 'user_id': 'abcd' } }
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.post('/posts/create', body, header)
      end

      it 'returns correct response' do
        expect(api.status).to eq(200)
        expect(api.body['data']['title']).to eq('aa')
        expect(api.body['data']['content']).to eq('cc')
      end
    end

    context 'with in-valid attribute values' do
      before do
        body = { 'posts': {} }
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.post('/posts/create', body, header)
      end

      it 'returns error response' do
        expect(api.body['status']).to eq(422)
        expect(api.body['message']).to eq('Failed to create post!')
      end
    end
  end

  describe 'GET top Post' do
    api = ClientApi::Api.new
    api.get('/login?username=admin&password=pass')
    token = api.body['token']
    context 'with valid attribute values' do
      before do
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.get_with_body('/posts/top_post', {}, header)
      end

      it 'returns correct response' do
        expect(api.status).to eq(200)
        expect(api.body).to be_an_instance_of(Array)
      end
    end
  end

  describe 'GET Post Auther with IP' do
    api = ClientApi::Api.new
    api.get('/login?username=admin&password=pass')
    token = api.body['token']
    context 'with valid attribute values' do
      before do
        header = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Authentication': token }
        api.get_with_body('/posts/list_users', {}, header)
      end

      it 'returns correct response' do
        expect(api.status).to eq(200)
        expect(api.body).to be_an_instance_of(Array)
      end
    end
  end
end
