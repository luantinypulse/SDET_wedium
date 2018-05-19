require 'rails_helper'

describe ArticlesController, type: :controller do
  before do
  end

  context 'when there is no filter param' do
    it 'return list of all articles' do
    end
  end

  context 'when params[:author] is exit' do
    it 'return list articles filtered by author name in param' do 
    end
  end

  context 'when params[:favorited] is exit' do
    it 'return list articles that favorited by username in params' do 
    end
  end

  context 'when params[:tag] is exit' do
    it 'return list article that have tag text as in param' do 
    end
  end
end
