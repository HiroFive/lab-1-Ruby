module QuizYourSurname
    class Question
      attr_accessor :question_body, :question_correct_answer, :question_answers
  
      def initialize(raw_text, raw_answers)
        @question_body = raw_text
        @question_correct_answer = raw_answers[0]
        @question_answers = load_answers(raw_answers)
      end
  
      def display_answers
        @question_answers.map { |char, answer| "#{char}. #{answer}" }
      end
  
      def to_s
        @question_body
      end
  
      def to_h
        {
          question_body: @question_body,
          question_correct_answer: @question_correct_answer,
          question_answers: @question_answers
        }
      end
  
      def to_json(*_args)
        to_h.to_json
      end
  
      def to_yaml(*_args)
        to_h.to_yaml
      end
  
      private
  
      def load_answers(raw_answers)
        shuffled_answers = raw_answers.shuffle
        ('A'..'Z').zip(shuffled_answers).to_h
      end
  
      public
  
      def find_answer_by_char(char)
        @question_answers[char]
      end
    end
  end
  