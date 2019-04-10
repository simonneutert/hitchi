class AnswersController < ApplicationController
  before_action :check_userpermission
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    redirect_to messages_path
    #@answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  # def show
  # end

  # GET /answers/new
  def new
    @message = Message.find(params[:message_id])
    @answer = @message.answers.new
    if current_user.id != @message.sender
      if current_user.id != @message.recipent
        redirect_to root_path
      end
    end

  end

  # GET /answers/1/edit
  def edit
    redirect_to messages_path
  end

  # POST /answers
  # POST /answers.json
  def create
    @message = Message.find(params[:message_id])
    if current_user.id != @message.sender
      if current_user.id != @message.recipent
        redirect_to root_path
      else
        @recipent = User.find(@message.sender)
        @message.recipentclick = true
        @message.senderclick = false
        UserMailer.msg_notification_email(@recipent).deliver_now if @recipent.email
        @message.save!
      end
    else
      @recipent = User.find(@message.recipent)
      @message.recipentclick = false
      @message.senderclick = true
      UserMailer.msg_notification_email(@recipent).deliver_now if @recipent.email
      @message.save!
    end
    @answer = @message.answers.new(answer_params)
    @answer.user_id = current_user.id
    @answer.recipent = @answer.message.recipent
    @answer.sender = current_user.id
    @answer.status = "r_unread"
    @message.touch

    respond_to do |format|
      if @answer.save
        format.html { redirect_to messages_path, notice: 'Deine Antwort wurde gespeichert.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to message_path(@message), notice: "Du musst einen Text eingeben." }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    redirect_to messages_path
  end
  # def update
  #   respond_to do |format|
  #     if @answer.update(answer_params)
  #       format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @answer }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @answer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    if @answer.sender != current_user.id
      redirect_to root_path
    end
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to messages_path, notice: 'Antwort gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def check_session_permission
      if session[:expires_at] < Time.current
        session[:user_id] = nil
        session[:expires_at] = Time.now
        redirect_to signout_path
      end
    end

    def check_userpermission
      if !current_user
        redirect_to root_path
      else
        if session[:expires_at]
          check_session_permission
        else
          redirect_to root_path
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:message_id, :content, :recipent, :sender, :user_id, :status)
    end
end
