module QuizDemianchuk
  class QuestionData
    attr_accessor :collection

    def initialize(yaml_dir: 'quiz/yml', in_ext: 'yml')
      @collection = []
      @yaml_dir = yaml_dir
      @in_ext = in_ext
      @threads = []
      load_data
    end

    def to_yaml
      @collection.to_yaml
    end

    def save_to_yaml(filename)
      File.write(filename, to_yaml)
    end

    def to_json
      @collection.to_json
    end

    def save_to_json(filename)
      File.write(filename, to_json)
    end

    def prepare_filename(filename)
      File.expand_path(filename, @yaml_dir)
    end

    def each_file
      Dir.glob(File.join(@yaml_dir, "*.#{@in_ext}")).each do |filename|
        yield(filename)
      end
    end

    def in_thread(&block)
      thread = Thread.new { block.call }
      @threads << thread
    end

    def load_data
      each_file do |filename|
        in_thread { load_from(filename) }
      end
      @threads.each(&:join)
    end

    def load_from(filename)
      data = YAML.load_file(filename)
      data.each do |question_data|
        question = Question.new(question_data['question'], question_data['answers'])
        @collection << question
      end
    end
  end
end
