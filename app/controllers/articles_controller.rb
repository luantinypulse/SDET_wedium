class ArticlesController < ApplicationController
  def index
    if params[:author].present?
      @articles = Article.author_by(params[:author])
    else
      @articles = Article.all
    end  
  end

  def show
    @articles = Article.all
  end
end
