module QuizYourSurname
    class Engine
      def initialize
        @question_collection = QuestionData.new
        @input_reader = InputReader.new
        @user_name = @input_reader.read(welcome_message: "Enter your username:")
        current_time = Time.now.strftime("%Y%m%d_%H%M%S")
        @writer = FileWriter.new('w', "#{@user_name}_#{current_time}.txt")
        @statistics = Statistics.new(@writer)
      end
  
      def run
        @question_collection.collection.each do |question|
          puts question.to_s
          @writer.write(question.to_s)
          question.display_answers.each do |answer|
            puts answer
            @writer.write(answer)
          end
  
          user_answer = get_answer_by_char(question)
          if check(user_answer, question.question_correct_answer)
            @statistics.correct_answer
          else
            @statistics.incorrect_answer
          end
        end
        @statistics.print_report
      end
  
      private
  
      def check(user_answer, correct_answer)
        user_answer.strip.downcase == correct_answer.strip.downcase
      end
  
      def get_answer_by_char(question)
        @input_reader.read(welcome_message: "Your answer:", validator: lambda { |input| !input.strip.empty? }, error_message: "Answer cannot be empty.", process: lambda { |input| question.find_answer_by_char(input.upcase) })
      end
    end
  end
  