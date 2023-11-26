class Api::V1::QuestionsController < ApplicationController
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
            answer: question.answer.present? ? question.answer : nil
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
end
