require 'pry'
module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index, :count]
      before_action :set_article, only: [:show, :update, :destroy]
  
      # GET /articles
      def index
        @articles = Article.all
        # @articles =Article.joins(:comments).select("articles.*, count(comments.id) AS comments_count").group('articles.id')
        
        render json: @articles
      end

      # GET /articles/1
      def show
        @article =Article.joins(:comments)
          .select("articles.*, count(comments.id) AS comments_count")
          .where('articles.id = ?', params[:id])
          .group('articles.id')

        render json: @article
      end

      # GET /count
      def count
        @count = Article.all.where(tag:'publish').count

        render json: @count
      end
 
      # POST /articles
      def create
        @article = current_user.articles.build(article_params)
  
        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end
  
      # PATCH/PUT /articles/1
      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end
  
      # DELETE /articles/1
      def destroy
        @article.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_article
          @article = Article.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def article_params
          params.require(:article).permit(:title, :body, :tag, :id)
        end
    end
  end
end
