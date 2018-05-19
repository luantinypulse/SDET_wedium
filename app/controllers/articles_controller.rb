# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = if params[:author].present?
                  Article.author_by(params[:author])
                elsif params[:favorited].present?
                  Article.favorited_by(params[:favorited])
                elsif params[:tag].present?
                  Article.tag_with(params[:tag])
                else
                  Article.all
                end
  end

  def show
    @articles = Article.all
  end
end
