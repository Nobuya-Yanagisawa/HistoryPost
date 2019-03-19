class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :correct_user,   only: :destroy

	def index
	end

	def show
	end

	def new
		@post = current_user.posts.build if logged_in?
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
	end

	def update
	end

	def destroy
    @post.destroy
    flash[:success] = "「#{@post.post_name}」を削除しました！"
    redirect_to request.referrer || root_url
	end

  private

    def post_params
      params.require(:post).permit(:post_name, :introduction, :sub_title, :content)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end