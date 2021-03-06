class PostsController < ApplicationController
	before_action :logged_in_user
	before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @title    = "解説一覧"
    @headline = "解説一覧"
    @message  = "解説がありません"
    if params[:q]
      relation = Post.joins(:user)
      @posts = relation.merge(User.search_by_keyword(params[:q]))
                      .or(relation.search_by_keyword(params[:q]))
                      .paginate(page: params[:page])
      @title    = "検索結果"
      @headline = "検索結果"
      @message  = "検索に該当する解説がありません"
    else
      @posts = Post.paginate(page: params[:page])
    end
  end

	def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build if logged_in?
    @comments = @post.comments.paginate(page: params[:page])
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
      redirect_to root_path
    else
      redirect_to root_path
    end
	end

  def timeline
    @posts = current_user.feed.paginate(page: params[:page])
  end

  def ranking
    # @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))

    # @posts = Post.select('posts.*', 'count(likes.id) AS likes').left_joins(:likes).group('posts.id').order('likes desc').paginate(page: params[:page])
  
    @posts = Post.all.sort_by{ |k, v| k.likes.count }.reverse.paginate(page: params[:page])
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