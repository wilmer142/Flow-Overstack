class QuestionsController < ApplicationController

	before_action :authenticate_user!, :except => [:show, :index]

  def index
  	@questions = Question.all
  end
  
  def show
  	@question = Question.find(params[:id])
    @answer = Answer.new
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
			flash[:danger] = "Ha ocurrido un error"
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
