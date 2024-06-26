module QuizDemianchuk
  class Statistics
    attr_accessor :correct_answers, :incorrect_answers

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
      total = @correct_answers + @incorrect_answers
      correct_percent = (@correct_answers.to_f / total) * 100
      report = <<-REPORT
      Test Report:
      Correct answers: #{@correct_answers}
      Incorrect answers: #{@incorrect_answers}
      Correct percentage: #{correct_percent.round(2)}%
      REPORT
      @writer.write(report)
      puts report
    end
  end
end
