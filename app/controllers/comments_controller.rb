class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_message
  before_action :find_comments, only: [:edit, :update, :destroy]

  def create
    @comment = @message.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'Comment created'
      redirect_to message_path(@message)
    else
      flash[:warning] = 'Error creating comment'
      render 'new'
    end
  end

def edit
end

def update
  if @comment.update(comment_params)
    flash[:success] = 'Comment updated.'
    redirect_to message_path(@message)
  else
    flash[:danger] = 'Error updating comment.'
    render 'edit'
  end
end

def destroy
  @comment.destroy
  flash[:danger] = 'Comment deleted.'
  redirect_to @message
end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_message
      @message = Message.find(params[:message_id])
    end

    def find_comments
      @comment = @message.comments.find(params[:id])
    end
end
