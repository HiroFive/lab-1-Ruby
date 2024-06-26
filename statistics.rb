module QuizDemianchuk
  class Statistics
    def initialize
      @correct_answers = 0
      @incorrect_answers = 0
    end

    def record_answer(is_correct)
      if is_correct
        @correct_answers += 1
      else
        @incorrect_answers += 1
      end
    end

    def generate_report
      total_questions = @correct_answers + @incorrect_answers
      correct_percentage = total_questions > 0 ? (@correct_answers.to_f / total_questions) * 100 : 0.0

      report = <<~REPORT
        Test Report:
        Correct answers: #{@correct_answers}
        Incorrect answers: #{@incorrect_answers}
        Correct percentage: #{correct_percentage}%
      REPORT

      report
    end
  end
end
