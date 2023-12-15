class Api::V1::PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show]

  def index
    @posts = @user.posts.includes(:comments, :likes).paginate(page: params[:page], per_page: 5)
    json_response = {
      posts: @posts.as_json(include: { comments: { include: :user }, likes: {} }),
      meta: {
        current_page: @posts.current_page,
        total_pages: @posts.total_pages,
        per_page: @posts.limit_value
      }
    }
    render json: JSON.pretty_generate(json_response)
  end

  # http://api/v1/users/:user_id/posts/all
  # e.g: http://localhost:3000/api/v1/users/1/posts/all

  def all
    @posts = Post.paginate(page: params[:page], per_page: params[:per_page] || 10)

    json_response = {
      posts: @posts.as_json(except: %i[comments likes]),
      meta: {
        current_page: @posts.current_page,
        total_pages: @posts.total_pages,
        per_page: @posts.limit_value
      }
    }

    render json: JSON.pretty_generate(json_response)
  end

  # http://localhost:3000/api/v1/users/:user_id/posts/:post_id
  # e.g: http://localhost:3000/api/v1/users/1/posts/1

  def show
    @comments = @post.comments.includes(:user)
    json_response = {
      post: @post.as_json(include: { comments: { include: :user } })
    }
    render json: JSON.pretty_generate(json_response)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
