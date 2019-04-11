class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.take(15)
      @posts_index = Post.all.take(15)
      @ranking = Post.all.sort_by{ |k, v| k.likes.count }.reverse.take(15)
    else
      @posts = Post.all.sort_by{ |k, v| k.likes.count }.reverse.take(5)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
