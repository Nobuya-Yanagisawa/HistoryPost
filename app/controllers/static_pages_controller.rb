class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @headline = "タイムライン"
      if params[:q]
        relation = Post.joins(:user)
        @feed_items = relation.merge(User.search_by_keyword(params[:q]))
                        .or(relation.search_by_keyword(params[:q]))
                        .paginate(page: params[:page])
        @headline = "検索結果"
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
    else
      @posts = Post.all.take(5)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
