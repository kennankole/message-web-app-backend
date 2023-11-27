class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    @questions = Question.all
    if @questions.any?
      question_info = @questions.map do |question|
        {
          question: {
            id: question.id,
            body: question.body,
            date_time: question.created_at,
            user_identity: question.user.present? ? question.user.user_identity : nil,
            answer: question.answer.present? ? question.answer.body : nil
          }
        }
      end
      render json: question_info
    else
      render json: {
        message: 'No questions found'
      }, status: :not_found
    end
  end

  def create
    if current_user.user_identity.start_with?("CU")
      @question = current_user.questions.build(question_params)

      if @question.save
        render json: {
          message: 'Your questions has been submitted successfully!'
        }
      else
        render json: {
          error: @question.errors.full_messages,
        }, status: :unprocessable_entity
      end
    else
      render json: {
        error: 'You are not authorized to perform this operation!'
      }, status: :unprocessable_entity
    end
  end


  private

  def question_params
    params.require(:question).permit(:body)
  end
end
