class AnswersController < ApplicationController

	before_action :authenticate_user!

  def create
  	@answer = Answer.new(answer_params)
  	if @answer.save
  		flash[:success] = "Respuesta añadida exitosamente!"
  		redirect_to question_path(@answer.question_id)
  end

  def update
  end

  def delete
  end
end
