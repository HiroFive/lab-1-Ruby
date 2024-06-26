require_relative 'quiz'

QuizDemianchuk::Quiz.config do |config|
  config.yaml_dir = 'quiz/yml'
  config.answers_dir = 'quiz/answers'
end
