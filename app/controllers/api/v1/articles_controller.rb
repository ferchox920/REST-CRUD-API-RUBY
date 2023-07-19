class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { status: 'SUCCESS', message: 'Loaded articles', data: articles }, status: :ok
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: { status: 'SUCCESS', message: 'Loaded article', data: article }, status: :ok
    else 
      render json: { status: 'ERROR', message: 'Article not found', data: {} }, status: :not_found
    end
  end

  def create
    article = Article.new(arti_params)
    if article.save
      render json: { status: 'SUCCESS', message: 'Saved article', data: article }, status: :ok
    else 
      render json: { status: 'ERROR', message: 'Article not saved', data: article.errors }, status: :unprocessable_entity
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article
      if article.update(arti_params)
        render json: { status: 'SUCCESS', message: 'Updated article', data: article }, status: :ok
      else
        render json: { status: 'ERROR', message: 'Article not updated', data: article.errors }, status: :unprocessable_entity
      end
    else
      render json: { status: 'ERROR', message: 'Article not found', data: {} }, status: :not_found
    end
  end  

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: { status: 'SUCCESS', message: 'Deleted article', data: article }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Article not found', data: {} }, status: :not_found
    end
  end

  private

  def arti_params
    params.require(:article).permit(:title, :body, :author)
  end
end
