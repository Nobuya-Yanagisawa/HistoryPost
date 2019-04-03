class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    if params[:q]
      @users = User.search_by_keyword(params[:q])
                        .paginate(page: params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
  end

	def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
    	flash[:success] = "ユーザー登録が完了しました！"
    	redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報の更新に成功しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if User.find(params[:id]).destroy
      flash[:success] = "ユーザーの削除に成功しました"
      redirect_to users_url
    else
      redirect_to root_path
    end
  end

  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

    def user_params
      params.require(:user).permit(:user_name, :email, :user_image,
                                   :password, :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
