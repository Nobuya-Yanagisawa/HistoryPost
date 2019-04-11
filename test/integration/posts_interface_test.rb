require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    # 無効な送信
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: {  post_name: "",
      																		sub_title: "",
      																		content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: {  post_name: "Test post name",
      																		sub_title: "Test subtitle",
      																		content: "Test content" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match "Test post name", response.body
    # 投稿を削除する
    assert_select 'a', text: '投稿を削除'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: '投稿を削除', count: 0
  end

  test "post sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.posts.count}件の投稿", response.body
    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0件の投稿", response.body
    other_user.posts.create!(post_name: "Test post name by malory",
      											 sub_title: "Test subtitle by malory",
    													 content: "Test content by malory")
    get root_path
    assert_match "1件の投稿", response.body
  end
end
