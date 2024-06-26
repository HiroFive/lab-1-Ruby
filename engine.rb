module QuizDemianchuk
  class Engine
    def initialize
      @statistics = Statistics.new
      @file_writer = FileWriter.new('w', "answers/#{ARGV[0]}_#{Time.now.strftime('%Y%m%d_%H%M%S')}.txt")
      @questions = load_questions('yml/questions.yml')
    end

    def run
      puts "Enter your name:"
      name = gets.chomp
      @file_writer = FileWriter.new('w', "#{name}_#{Time.now.strftime('%Y%m%d_%H%M%S')}.txt")

      @questions.each do |q|
        puts q[:question]
        q[:answers].each_with_index do |answer, index|
          puts "#{index + 1}. #{answer}"
        end
        answer_index = gets.chomp.to_i - 1
        is_correct = (q[:answers][answer_index] == q[:correct_answer])
        @statistics.record_answer(is_correct)
        @file_writer.write("Question: #{q[:question]}, Answer: #{q[:answers][answer_index]}, Correct: #{is_correct}")
      end

      report = @statistics.generate_report
      puts report
      @file_writer.write(report)
    end

    private

    def load_questions(file_path)
      questions = YAML.load_file(file_path)
      questions.map do |q|
        correct_answer = q['answers'].first
        {
          question: q['question'],
          answers: q['answers'],
          correct_answer: correct_answer
        }
      end
    end
  end
end
