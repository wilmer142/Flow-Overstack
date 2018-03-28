class VotesController < ApplicationController

	before_action :authenticate_user!

	def voteup
		@vote = Vote.new(vote_params)		
		if @vote.save
			flash[:success] = "Voto añadito correctamente"
		else
			vote_params[:voteable_type] == 'Question' ?  tipo = "Pregunta" : tipo = "Respuesta"
			flash[:warning] = "#{@vote.errors.messages[:user_id][0]} para esta #{tipo}"
		end

		if vote_params[:voteable_type] == 'Question'
			redirect_to question_path(vote_params[:voteable_id])
		else
			@answer = Answer.find(vote_params[:voteable_id])
			redirect_to question_path(@answer.question_id)
		end
	end

	def votedown
		@vote = Vote.find_by(voteable_type: vote_params[:voteable_type], 
			voteable_id: vote_params[:voteable_id], user_id: vote_params[:user_id])
		if !@vote.nil?
			if @vote.destroy
				flash[:success] = "Voto anulado correctamente"
			else
				flash[:danger] = "Ha ocurrido un error"
			end
		else
			vote_params[:voteable_type] == 'Question' ? 
				(flash[:warning] = "No tiene un voto registrado para esta pregunta") :
				(flash[:warning] = "No tiene un voto registrado para esta respuesta")
		end
		
		if vote_params[:voteable_type] == 'Question'
			redirect_to question_path(vote_params[:voteable_id])
		else
			@answer = Answer.find(vote_params[:voteable_id])
			redirect_to question_path(@answer.question_id)
		end
	end

	private 
		def vote_params
      params.require(:vote).permit(:user_id, :voteable_type, :voteable_id)
    end

end
