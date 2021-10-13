class ArticlesController < ApplicationController
  before_action :authenticate_user!,only: [:new,:create,:edit,:destroy]
  before_action :correct_user,      only: [:edit, :destroy]
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "Article created!"
      redirect_to root_url
    else
      render new_article_path
      flash[:alert]= "Invalid Post"
    end
  end
  
  def edit
  end
  
  def update
    @article = Article.find(params[:id])
      if @article.update(article_params)
        redirect_to root_url
        flash[:notice]= "Article Edited!"
      else
        redirect_to request.referer
        flash[:alert]= "Invalid Post"
      end
  end
  
  def destroy
    @article.destroy 
    flash[:notice] = "Article destroyed"
    redirect_to root_url
  end
  
  private
  
    def article_params
      params.require(:article).permit(:title, :content)
    end
    
    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      if @article.nil?
        redirect_to root_url 
        flash[:notice] = "Not Yours"
      end
    end
end
