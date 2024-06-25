module QuizYourSurname
    class Quiz
      include Singleton
  
      attr_accessor :yaml_dir, :in_ext, :answers_dir
  
      def config
        yield self
      end
    end
  end
  