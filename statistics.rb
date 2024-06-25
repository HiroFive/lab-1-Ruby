module QuizYourSurname
    class Statistics
      def initialize(writer)
        @correct_answers = 0
        @incorrect_answers = 0
        @writer = writer
      end
  
      def correct_answer
        @correct_answers += 1
      end
  
      def incorrect_answer
        @incorrect_answers += 1
      end
  
      def print_report
        total_answers = @correct_answers + @incorrect_answers
        percentage_correct = (@correct_answers.to_f / total_answers) * 100
        report = <<-REPORT
          Test Results:
          Correct Answers: #{@correct_answers}
          Incorrect Answers: #{@incorrect_answers}
          Percentage Correct: #{percentage_correct.round(2)}%
        REPORT
        @writer.write(report)
        puts report
      end
    end
  end
  