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
		redirect_to question_path(vote_params[:voteable_id])
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
		redirect_to question_path(vote_params[:voteable_id])
	end

	private 
		def vote_params
      params.require(:vote).permit(:user_id, :voteable_type, :voteable_id)
    end

end
