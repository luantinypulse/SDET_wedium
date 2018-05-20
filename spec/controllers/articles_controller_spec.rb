# frozen_string_literal: true

require 'rails_helper'

describe ArticlesController, type: :controller do
  render_views

  describe 'GET index' do
    context 'when there is no filter param and no articles in DB' do
      it 'returns 200' do
        get :index
        expect(response).to have_http_status(200)
      end

      it 'returns include 2 elements' do
        get :index
        expect(response.body).to include 'articlesCount'
        expect(response.body).to include 'articles'
      end

      it 'returns empty list of articles when there is no any article' do
        get :index, 'author' => 'Luan', 'article' => {}
        expect(JSON[response.body]['articles']).to eq []
      end
    end

    context 'when there is no filter and have articles in DB' do
      let!(:user1) { User.create(name: 'Luan Ta') }
      let!(:user2) { User.create(name: 'Ngoc Nguyen') }
      let!(:article1) { Article.create(user_id: User.first.id) }
      let!(:article2) { Article.create(user_id: User.second.id) }

      it 'returns list all articles' do
        get :index
        value = JSON[response.body]['articles']
        expect(value.count).to eq 2
        expect(value.first['id']).to eq article1.id
        expect(value.second['id']).to eq article2.id
      end
    end

    context 'when there is filter by author' do
      let!(:user1) { User.create(name: 'Luan 1') }
      let!(:user2) { User.create(name: 'Luan 2') }
      let!(:article1) { Article.create(user_id: User.first.id) }
      let!(:article2) { Article.create(user_id: User.second.id) }

      it 'returns list articles filtered by author name in param' do
        get :index, author: 'Luan'
        value = JSON[response.body]['articles']
        expect(value.count).to eq 2
        expect(value.first['id']).to eq article1.id
        expect(value.second['id']).to eq article2.id
      end

      it 'returns correct articles filtered by author name' do
        get :index, author: ' 1'
        value = JSON[response.body]['articles']
        expect(value.count).to eq 1
        expect(value.first['id']).to eq article1.id
      end

      it 'returns list articles that favorited by username in params' do
        get :index, author: 'not matched any'
        value = JSON[response.body]['articles']
        expect(value.count).to eq 0
      end

      it 'return correct list article even there are spaces before/after params' do
        get :index, author: '           1         '
        value = JSON[response.body]['articles']
        expect(value.count).to eq 1
        expect(value.first['id']).to eq article1.id
      end
    end

    context 'when there is filter by favorited' do
      it 'TO DO'
    end

    context 'when there is filter by tag' do
      it 'TO DO'
    end
  end
end
