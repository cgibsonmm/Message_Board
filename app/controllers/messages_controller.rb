class MessagesController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all.order('created_at DESC')
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = "Message Created"
      redirect_to root_path
    else
      flash[:warning] = "Error creating Message"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'Message Updated'
      redirect_to @message
    else
      flash[:warning] = 'Error updating message'
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    flash[:success] = 'Message destroyed'
    redirect_to root_path 
  end

  private

    def message_params
      params.require(:message).permit(:title, :description)
    end

    def find_message
      @message = Message.find(params[:id])
    end
end
