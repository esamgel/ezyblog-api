class HomeController < ApplicationController
  def index
    # @article = Article.all
    @article = Article.where(tag: 'publish').all
    render json: @article
  end
end