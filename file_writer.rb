module QuizYourSurname
    class FileWriter
      def initialize(mode, *args)
        @answers_dir = "quiz/answers"
        @filename = prepare_filename(args[0])
        @mode = mode
      end
  
      def write(message)
        File.open(@filename, @mode) do |file|
          file.puts(message)
        end
      end
  
      private
  
      def prepare_filename(filename)
        File.expand_path(File.join(@answers_dir, filename))
      end
    end
  end
  