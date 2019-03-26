class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:success] = "コメントの投稿に成功しました"
			redirect_to @post
		else
			flash[:danger] = "コメントの投稿に失敗しました"
			@comment = @post.comments.build if logged_in?
    	@comments = @post.comments.page(params[:page])
			render 'posts/show'
		end
	end

	def destroy
    @comment = Comment.find(params[:comment_id])
    if @comment.destroy
			flash[:success] = "コメントの削除に成功しました"
    	redirect_to post_path(params[:post_id])
		else
			flash[:danger] = "コメントの削除に失敗しました"
			@comment = @post.comments.build if logged_in?
    	@comments = @post.comments.page(params[:page])
			render 'posts/show'
		end
  end

	private

		def comment_params
			params.require(:comment).permit(:user_id, :post_id, :comment_content)
		end
end
