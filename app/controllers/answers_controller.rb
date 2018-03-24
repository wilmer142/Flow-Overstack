class AnswersController < ApplicationController

	before_action :authenticate_user!

  def create
  	@answer = Answer.new(answer_params)
  	if @answer.save
  		flash[:success] = "Respuesta añadida exitosamente!"
  		redirect_to question_path(@answer.question_id)
    else
      flash[:danger] = "Ha ocurrido un error"
      redirect_to question_path(@answer.question_id)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      flash[:success] = "Respuesta eliminada exitsaomente!"
    else
      flash[:danger] = "Ha ocurrido un error"
    end
    redirect_to question_path(@answer[:question_id])
  end

  private

    def answer_params
      params.require(:answer).permit(:content, :votes, :user_id, :question_id)
    end
end
