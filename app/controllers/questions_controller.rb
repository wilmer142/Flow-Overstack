class QuestionsController < ApplicationController

	before_action :authenticate_user!, :except => [:show, :index]

  def index
  	@questions = Question.all
  end
  
  def show
  	@question = Question.find(params[:id])
  end

  def new
  	@question = Question.new
  end

  def create
  	@question = Question.new(question_params)
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
  end

  def update
  	@question = Question.find(params[:id])
  	if @question.update(question_params)
  		flash[:success] = "Pregunta modificada exitosamente!"
  		redirect_to questions_path
  	else
  		flash[:danger] = "Ha ocurrido un error"
  		render :edit
  	end
  end

  def destroy
  	@question = Question.find(params[:id])
  	if @question.destroy
  		flash[:success] = "Pregunta eliminada exitosamente!"
  		redirect_to questions_path
  	else
  		flash[:danger] = "Ha ocurrido un error"
  		render :show
  	end
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
