class CommentsController < ApplicationController
  before_action :find_article, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :logged_in_user
  before_action :author, only: [:edit, :update, :destroy]
  def new
    @comment = @article.comments.build
  end

  def edit
    #@comment = @article.comments.find(params[:id])
  end

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment was created successfuly"
      redirect_to article_path(@article)
    else
      #there is no flas[:error] because when we will show validation errors
      render 'new'
    end
  end
  
  def update
    #@comment = @article.comments.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "comment was updated"
      redirect_to article_path(@article)
    else
      #there is no flas[:error] because when we will show validation errors
      render 'edit'
    end
  end

  def destroy
    #@comment = @article.comments.find(params[:id])
    if @comment.destroy
      flash[:notice] = "comment was deleted"
      redirect_to article_path(@article)
    else
      flash[:notice] = "unable to delete comment"
      redirect_to article_path(@article)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = @article.comments.find(params[:id])
    end

    def author
      unless @comment.user == current_user
        flash[:notice] = "Insufficient privilage"
        redirect_to articles_path
      end
    end
end
