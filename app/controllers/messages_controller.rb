class MessagesController < ApplicationController
  before_action :check_userpermission
  before_action :set_message, only: [:show, :edit, :update, :destroy, :markread]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where("recipent = #{current_user.id} OR sender = #{current_user.id}").order(updated_at: :desc)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    if current_user.id != @message.sender
      if current_user.id != @message.recipent
        redirect_to signout_path and return
      else
        # TODO: use update_attribute?
        @message.recipentclick = true
        @message.save!
      end
    else
      # TODO: use update_attribute?
      @message.senderclick = true
      @message.save!
    end
    @answer = Message.find(params[:id]).answers.build
  end

  def markread
    if current_user.id != @message.sender
      if current_user.id != @message.recipent
        redirect_to signout_path
      else
        @message.recipentclick = true
        @message.save!
      end
    else
      @message.senderclick = true
      @message.save!
    end
    redirect_to messages_path
  end

  # GET /messages/new
  def new
    @offer = Offer.find(params[:offer_id])
    # prevent user from contacting themself
    if @offer.user_id != current_user.id
      if Message.where(offer_id: @offer, sender: current_user.id).any?
        @message = Message.where(offer_id: @offer, sender: current_user.id).first
        redirect_to message_path(@message)
      else
        @message = @offer.messages.new
      end
    else
      redirect_to offers_overview_path, notice: "Du kannst dich nicht selbst kontaktieren ;-)"
    end
  end

  # GET /messages/1/edit
  def edit
    redirect_to messages_path
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.recipent = @message.offer.user_id
    @message.sender = current_user.id
    @message.status = "r_unread"
    @message.recipentclick = false
    @message.senderclick = true
    @recipent = User.find(@message.recipent)
    respond_to do |format|
      if @message.save
        # send mail if user has email...
        UserMailer.msg_notification_email(@recipent).deliver_now if @recipent.email
        format.html { redirect_to messages_path, notice: 'Deine Nachricht wurde verschickt.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    redirect_to messages_path
  end
  # def update
  #   respond_to do |format|
  #     if @message.update(message_params)
  #       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @message }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @message.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_path, notice: 'Die gesamte Konversation wurde gelöscht.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
      @answers = @message.answers
      # rescue if message isn't properly owned
      redirect_to signout_path if (@message.sender != current_user.id && @message.recipent != current_user.id)
    end

    def check_session_permission
      if session[:expires_at] < Time.current
        session[:user_id] = nil
        session[:expires_at] = Time.now
        redirect_to signout_path
      end
    end

    def check_userpermission
      # always check for current_user status first
      if !current_user
        redirect_to signout_path
      else
        if session[:expires_at]
          check_session_permission
        else
          redirect_to signout_path
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(
      :content,
      :recipent,
      :sender,
      :user_id,
      :offer_id,
      :status,
      :recipentclick,
      :senderclick
      )
    end
end
