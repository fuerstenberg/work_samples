class MessagesController < ApplicationController

  before_action :set_objects
  before_action :set_as_read

  def index
  end

  def create
    if @message = @conversation.messages.create(body: message_params[:body], sender: current_user)
      redirect_to [@conversation, :messages], notice: "Deine Nachricht wurde erfolgreich versendet."
    else
      redirect_to [@conversation, :messages], alert: "Bitte gib eine Nachricht ein."
    end
  end

  # def destroy
  #   @message = current_user.messages.find params[:id]
  #   @user = @message.received_messageable == current_user ? @message.sent_messageable : @message.received_messageable
  #   current_user.delete_message(@message)
  #   respond_to do |format|
  #     format.html { redirect_to account_message_url(id: @user.id), notice: "Die Nachricht wurde entfernt." }
  #     format.js   { render nothing: true }
  #   end
  # end

  private

  def message_params
    params.require(:message).permit :body
  end

  def set_as_read
    @conversation&.read_by! current_user
  end

  def set_objects
    if params[:conversation_id] == 'new' and @user and @user != current_user
      @conversation = current_user.conversations.find_or_create_by_members current_user, @user
    elsif params[:conversation_id]
      @conversation = current_user.conversations.find params[:conversation_id]
    end
    @conversations = current_user.conversations.order(updated_at: :desc)
  end

end
