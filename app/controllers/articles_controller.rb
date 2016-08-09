class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update, :create, :destroy]
  before_action :author, only: [:edit, :update, :destroy]
	def index
		@articles = Article.all
	end

	def show
		#there is a filter
	end

	def new
      @article = Article.new
	end

	def edit
		#there is a filter
	end

	def create
		@article = current_user.articles.new(article_params)
		respond_to do |format|
			if @article.save
				format.html do
			    flash[:notice] = "Article was created successfully"
			    redirect_to articles_path
			  end
			  format.json {render json: @article, status: :ok}
		  else
		    format.html{ render 'new'}
			  format.json{render json: @article.errors, status: :unprocessable_entity}
		  end
		end
		
	end

	def update
		if @article.update(article_params)
			flash[:notice] = "Article was updated successfully"
			redirect_to @article, notice: 'Article was updated successfully'
		else
			render 'edit'
		end
	end

	def destroy
		if @article.destroy
			flash[:notice] = "Article was deleted"
			redirect_to articles_path
		else
			flash[:notice] = "unable to delete Article"
			redirect_to @article
		end
	end

	private

		def set_article
			@article = Article.find(params[:id])
		end

	  def article_params
		  params.require(:article).permit(:title, :content)
	  end

	  def author
	  	unless @article.user == current_user
			  flash[:notice] = "Insufficient privilage"
			  redirect_to articles_path
		  end
	  end
end
