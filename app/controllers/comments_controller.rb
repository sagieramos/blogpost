class CommentsController < ApplicationController
  def new
    post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.create(post_params(post))
    if @comment.save
      flash[:notice] = 'Comment created successfully'
      redirect_to user_post_path(current_user, post)
    else
      flash.now[:error] = "Error: Couldn't create comment"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params(post)
    a_post = params.require(:comment).permit(:text)
    a_post[:author] = current_user
    a_post[:post] = post
    a_post
  end
end
