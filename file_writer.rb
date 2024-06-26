module QuizDemianchuk
  class FileWriter
    def initialize(mode, *args)
      @answers_dir = 'quiz/answers'
      @filename = prepare_filename(args[0])
      @mode = mode
    end

    def write(message)
      File.open(@filename, @mode) { |file| file.puts(message) }
    end

    def prepare_filename(filename)
      File.expand_path(filename, @answers_dir)
    end
  end
end
