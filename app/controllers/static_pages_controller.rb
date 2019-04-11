class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.take(30)
      @posts_index = Post.all.take(30)
      @ranking = Post.all.reverse_order.take(30)
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
