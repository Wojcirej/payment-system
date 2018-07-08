require 'pry'
class Deploy
  include Stages

  attr_accessor :stage, :migrations

  def initialize(options)
    @stage = options[:stage]
    @migrations = options[:migrations]
  end

  def self.run(options)
    new(options).run
  end

  def run
    unless valid_stage?(stage)
      puts "Deploy aborted - invalid stage!"
      return
    end
    msg = "Deploying to #{stage}, #{with_or_without_migrations?} migrations..."
    puts msg
    run_migrations if migrations
    push
  end

  private

  def with_or_without_migrations?
    migrations ? "with" : "without"
  end

  def run_migrations
    puts "Putting #{stage} in maintenance mode..."
    system "heroku maintenance:on --remote #{stage}"
    puts "Running migrations..."
    system "heroku run rake db:migrate --remote #{stage}"
    puts "Disabling maintenance mode on #{stage}..."
    system "heroku maintenance:off --remote #{stage}"
  end

  def push
    system "git push #{stage} #{branch[stage.to_sym]}:master"
  end

  def branch
    {
      "staging": "develop",
      "production": "master"
    }
  end
end
