class Api::V1::AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    if @question && current_user.user_identity.start_with?("AG")
      @answer = current_user.answers.build(answer_params.merge(question: @question))
      
      if @answer.save
        render json: {
          message: 'Your answer was submitted successfully!'
        }
      else
        render json: {
          error: 'Operation unsuccesful!',
          details: @answer.errors.full_messages
        }, status: :unprocessable_entity
      end
    else
      render json: {
        error: 'You are not authorized to perform this operation!'
      }, status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
