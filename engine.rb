module QuizDemianchuk
  class Engine
    def initialize
      @question_collection = QuestionData.new
      @input_reader = InputReader.new
      @user_name = @input_reader.read(welcome_message: 'Enter your name:')
      @current_time = Time.now.strftime('%Y%m%d_%H%M%S')
      @writer = FileWriter.new('w', "#{@user_name}_#{@current_time}.txt")
      @statistics = Statistics.new(@writer)
    end

    def run
      @question_collection.collection.each do |question|
        puts question
        @writer.write(question.to_s)
        question.display_answers.each { |answer| puts answer }
        user_answer = get_answer_by_char(question)
        check(user_answer, question.question_correct_answer)
      end
      @statistics.print_report
    end

    def check(user_answer, correct_answer)
      if user_answer == correct_answer
        puts 'Correct!'
        @statistics.correct_answer
      else
        puts 'Incorrect!'
        @statistics.incorrect_answer
      end
    end

    def get_answer_by_char(question)
      @input_reader.read(
        welcome_message: 'Your answer:',
        validator: ->(input) { !input.empty? && question.question_answers.key?(input.upcase) },
        error_message: 'Invalid answer. Please try again.',
        process: ->(input) { input.strip.upcase }
      )
    end
  end
end
