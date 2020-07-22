class Admin::MessagesController < Admin::ApplicationController
  
  def index
    
  end
  
  def new
    @message = Message.new :sender => current_user
  end
  
  def create
    if Message.send_to_all(params[:message])
      redirect_to [:admin, :messages], :notice => "System successfully message sent!"
    else
      @message = Message.new params[:message]
      @message.valid?
      render :new
    end
  end
  
end