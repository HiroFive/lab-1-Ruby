module QuizDemianchuk
  class FileWriter
    def initialize(mode, *args)
      @answers_dir = 'answers/'
      create_directory(@answers_dir) # Ensure the directory exists
      @filename = prepare_filename(args[0])
      @mode = mode
    end

    def write(message)
      File.open(@filename, @mode) { |file| file.puts(message) }
    end

    def prepare_filename(filename)
      File.expand_path(filename, @answers_dir)
    end

    private

    def create_directory(directory)
      FileUtils.mkdir_p(directory) unless Dir.exist?(directory)
    end
  end
end