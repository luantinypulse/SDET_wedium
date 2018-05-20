# frozen_string_literal: true

require 'rails_helper'

describe ArticlesController, type: :controller do
  render_views
  let(:json) { JSON.parse(response.body) }
  let(:value) { json['articles'] }

  describe 'GET index' do
    context 'when there is no filter param and no articles in DB' do
      it 'returns 200' do
        get :index
        expect(response).to have_http_status(200)
      end

      it 'returns include 2 elements' do
        get :index
        expect(json).to have_key 'articlesCount'
        expect(json).to have_key 'articles'
      end

      it 'returns empty list of articles when there is no any article' do
        get :index, 'author' => 'Luan', 'article' => {}
        expect(value).to eq []
      end
    end

    context 'when there is no filter and have articles in DB' do
      let!(:user1) { User.create(name: 'Luan Ta') }
      let!(:user2) { User.create(name: 'Ngoc Nguyen') }
      let!(:article1) { Article.create(user_id: user1.id) }
      let!(:article2) { Article.create(user_id: user2.id) }

      it 'returns list all articles' do
        get :index
        expect(value.count).to eq 2
        expect(value.first['id']).to eq article1.id
        expect(value.second['id']).to eq article2.id
      end
    end

    context 'when there is filter by author' do
      let!(:user1) { User.create(name: 'Luan 1') }
      let!(:user2) { User.create(name: 'Luan 2') }
      let!(:article1) { Article.create(user_id: user1.id) }
      let!(:article2) { Article.create(user_id: user2.id) }

      it 'returns list articles filtered by author name in param' do
        get :index, author: 'Luan'
        expect(value.count).to eq 2
        expect(value.first['id']).to eq article1.id
        expect(value.second['id']).to eq article2.id
      end

      it 'returns correct articles filtered by author name' do
        get :index, author: ' 1'
        expect(value.count).to eq 1
        expect(value.first['id']).to eq article1.id
      end

      it 'returns list articles that favorited by username in params' do
        get :index, author: 'not matched any'
        expect(value.count).to eq 0
      end

      it 'return correct list article even there are spaces before/after params' do
        get :index, author: '           1         '
        expect(value.count).to eq 1
        expect(value.first['id']).to eq article1.id
      end
    end

    context 'when there is filter by favorited' do
      let!(:user1) { User.create(name: 'Luan 1') }
      let!(:user2) { User.create(name: 'Luan 2') }
      let!(:article1) { Article.create(user_id: user1.id) }
      let!(:article2) { Article.create(user_id: user2.id) }
      let!(:favorite1) { Favorite.create(user_id: user1.id, article_id: article1.id) }
      let!(:favorite2) { Favorite.create(user_id: user1.id, article_id: article2.id) }

      it 'return empty list when there is no favorited article by username' do
        get :index, 'favorited' => 'Luan 2'
        expect(value.count).to eq 0
      end

      it 'return empty list when there is no valid username' do
        get :index, 'favorited' => 'no valid user name'
        expect(value.count).to eq 0
      end

      it 'returns correct list of favorited by user name' do
        get :index, 'favorited' => 'Luan 1'

        expect(value.count).to eq 2
        expect(value.first['id']).to eq article1.id
        expect(value.second['id']).to eq article2.id
      end

      it 'returns correect list support trim space' do
        get :index, 'favorited' => '         Luan 1'

        expect(value.count).to eq 2
      end
    end

    context 'when there is filter by tag' do
      let!(:user1) { User.create(name: 'Luan 1') }
      let!(:user2) { User.create(name: 'Luan 2') }
      let!(:article1) { Article.create(user_id: user1.id) }
      let!(:article2) { Article.create(user_id: user2.id) }
      let!(:tag1) { Tag.create(name: 'Tagging 1') }
      let!(:tag2) { Tag.create(name: 'Tagging 2') }
      let!(:tag3) { Tag.create(name: 'Tagging 3') }
      let!(:tagging1) { Tagging.create(tag_id: tag1.id, article_id: article1.id) }
      let!(:tagging2) { Tagging.create(tag_id: tag1.id, article_id: article2.id) }
      let!(:tagging3) { Tagging.create(tag_id: tag2.id, article_id: article1.id) }

      it 'returns empty list when there is no matched tag name' do
        get :index, 'tag' => 'no matched result'
        expect(value.count).to eq 0
      end

      it 'returns empty list when there is no matched articles' do
        get :index, 'tag' => 'Tagging 3'
        expect(value.count).to eq 0
      end

      it 'returns correct list articles having tag' do
        get :index, 'tag' => 'Tagging 1'
        expect(value.count).to eq 2
        expect(value.first['id']).to eq article1.id
        expect(value.second['id']).to eq article2.id
      end

      it 'returns correct list article having tag' do
        get :index, 'tag' => 'Tagging 2'
        expect(value.count).to eq 1
        expect(value.first['id']).to eq article1.id
      end
    end
  end
end
