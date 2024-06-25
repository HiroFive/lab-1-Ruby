module QuizYourSurname
    class QuestionData
      attr_accessor :collection
  
      def initialize(yaml_dir: "quiz/yml", in_ext: "yml")
        @yaml_dir = yaml_dir
        @in_ext = in_ext
        @threads = []
        @collection = []
        load_data
      end
  
      def to_yaml
        @collection.to_yaml
      end
  
      def save_to_yaml(filename)
        File.write(prepare_filename(filename), to_yaml)
      end
  
      def to_json
        @collection.to_json
      end
  
      def save_to_json(filename)
        File.write(prepare_filename(filename), to_json)
      end
  
      private
  
      def prepare_filename(filename)
        File.expand_path(filename, __dir__)
      end
  
      def each_file
        Dir.glob(File.join(@yaml_dir, "*.#{@in_ext}")) do |file|
          yield(file)
        end
      end
  
      def in_thread(&block)
        @threads << Thread.new(&block)
      end
  
      def load_data
        each_file do |filename|
          in_thread { load_from(filename) }
        end
        @threads.each(&:join)
      end
  
      def load_from(filename)
        data = YAML.load_file(filename)
        data.each do |item|
          question = Question.new(item['question'], item['answers'])
          @collection << question
        end
      end
    end
  end
  