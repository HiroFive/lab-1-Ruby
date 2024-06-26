module QuizDemianchuk
  class Quiz
    @yaml_dir = 'quiz/yml'
    @answers_dir = 'quiz/answers'

    class << self
      attr_accessor :yaml_dir, :answers_dir

      def config
        yield self
      end
    end
  end
end
