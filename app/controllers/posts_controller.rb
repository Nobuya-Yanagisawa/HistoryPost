class PostsController < ApplicationController
	before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update, :destroy]

	def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build if logged_in?
    @comments = @post.comments.page(params[:page])
	end

	def new
		@post = current_user.posts.build if logged_in?
    @headline = @post.headlines.build
	end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "「#{@post.post_name}」の投稿に成功しました！"
      redirect_to root_url
    else
      render 'posts/new'
    end
  end

	def edit
    @post = Post.find(params[:id])
	end

	def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "投稿内容の編集に成功しました！"
      redirect_to @post
    else
      render 'edit'
    end
	end

	def destroy
    if Post.find(params[:id]).destroy
      flash[:success] = "「#{@post.post_name}」を削除しました！"
      redirect_to posts_path
    else
      redirect_to root_path
    end
	end

  private

    def post_params
      params.require(:post).permit(:post_name, :introduction, :post_image, :sub_title, :content,
                                   headlines_attributes: [:id, :headline_name, :headline_content, :_destroy])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end