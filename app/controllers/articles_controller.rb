class ArticlesController < ApplicationController
  def index
    if params[:author].present?
      @articles = Article.author_by(params[:author])
    elsif params[:favorited].present?
      @articles = Article.favorited_by(params[:favorited])
    elsif params[:tag].present?
      @articles = Article.tag_with(params[:tag])
    else
      @articles = Article.all
    end
  end

  def show
    @articles = Article.all
  end
end
