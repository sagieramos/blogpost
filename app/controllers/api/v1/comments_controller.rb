class Api::V1::CommentsController < ApplicationController
    before_action :set_user
    before_action :set_post
    before_action :set_comments, only: [:index]
    
    # http://api/v1/users/:user_id/posts/:post_id/comments
    # e.g: http://localhost:3000/api/v1/users/1/posts/1/comments

    def index
      comments_data = @comments.map do |comment|
        {
          id: comment.id,
          text: comment.text,
          author_name: comment.user.name
        }
      end
  
      render json: comments_data
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_post
      @post = @user.posts.find(params[:post_id])
    end
  
    def set_comments
      @comments = @post.comments.includes(:user)
    end
  end
  