class QuestionsController < ApplicationController

	before_action :authenticate_user!, :except => [:show, :index]

  def index
    if params["filtro"].nil?
      @questions = Question.all
    else
      @users = User.where("email like ?", "%#{params["filtro"]}%")
      @questions = Question.new
      if !@users.blank?
        @users.each do |user|
          @questions = Question.where("title like ?", "%#{params["filtro"]}%").or(Question.where("description like ?", "%#{params["filtro"]}%")).or(Question.where("user_id = ?", "#{user[:id]}"))
        end  
      else
        @questions = Question.where("title like ?", "%#{params["filtro"]}%").or(Question.where("description like ?", "%#{params["filtro"]}%"))
      end
      
    end
  end
  
  def show
  	@question = Question.find(params[:id])
    @answer = Answer.new
    @vote = Vote.new
    current_user.nil? ? user_vote = 0 : user_vote = current_user[:id]

    @question_has_voted = Vote.find_by(voteable_id: params[:id], user_id: user_vote, 
      voteable_type: 'Question')
    @comment = Comment.new
  end

  def new
  	@question = Question.new
  end

  def create
  	@question = Question.new(question_params)
    @question[:user_id] = current_user[:id]
		if @question.save
			flash[:success] = "Pregunta agregada exitosamente!"
			redirect_to questions_path  	
		else
			flash[:danger] = @question.errors.full_messages.to_sentence
			render :new
		end
  end

  def edit
  	@question = Question.find(params[:id])
    if @question[:user_id] == current_user[:id] 
    else
      flash[:danger] = "Usted no esta autorizado para editar esta pregunta"
      redirect_to question_path(@question[:id])
    end
  end

  def update
  	@question = Question.find(params[:id])
    if @question[:user_id] == current_user[:id] 
    	if @question.update(question_params)
    		flash[:success] = "Pregunta modificada exitosamente!"
    		redirect_to questions_path
    	else
    		flash[:danger] = "Ha ocurrido un error"
    		render :edit
    	end
    else
      flash[:danger] = "Usted no esta autorizado para editar esta pregunta"
      redirect_to question_path(@question[:id])
    end
  end

  def destroy
  	@question = Question.find(params[:id])
    if @question[:user_id] == current_user[:id] 
    	if @question.destroy
    		flash[:success] = "Pregunta eliminada exitosamente!"
    		redirect_to questions_path
    	else
    		flash[:danger] = "Ha ocurrido un error"
    		render :show
    	end
    else
      flash[:danger] = "Usted no esta autorizado para eliminar esta pregunta"
      redirect_to question_path(@question[:id])
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :description, :user_id)
    end
end
