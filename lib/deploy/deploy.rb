require_relative 'versioner.rb'
class Deploy
  include Stages

  def initialize(options)
    @options = options
    @stage = options[:stage]
    @migrations = options[:migrations]
    @bump = options[:bump]
  end

  def self.run(options)
    new(options).run
  end

  def run
    unless valid_stage?(stage)
      puts "Deploy aborted - invalid stage!"
      return
    end
    puts full_deploy_message
    bump_version if bump
    if migrations
      enable_maintenance_mode
      push
      run_migrations
      disable_maintenance_mode
    else
      push
    end
  end

  private
  attr_reader :options, :stage, :migrations, :bump

  def full_deploy_message
    "Deploying to #{stage}, #{migrations_message}, #{bump_message}..."
  end

  def migrations_message
    migrations ? "with migrations" : "without migrations"
  end

  def bump_message
    bump ? "with #{bump} bump" : "without version bump"
  end

  def enable_maintenance_mode
    puts "Putting #{stage} in maintenance mode..."
    system(enable_maintenance_mode_command)
  end

  def enable_maintenance_mode_command
    "heroku maintenance:on --remote #{stage}"
  end

  def run_migrations
    puts "Running migrations..."
    system(run_migrations_command)
  end

  def run_migrations_command
    "heroku run rake db:migrate --remote #{stage}"
  end

  def disable_maintenance_mode
    puts "Disabling maintenance mode on #{stage}..."
    system(disable_maintenance_mode_command)
  end

  def disable_maintenance_mode_command
    "heroku maintenance:off --remote #{stage}"
  end

  def push
    system(push_command)
  end

  def push_command
    "git push #{stage} #{branch[stage.to_sym]}:master"
  end

  def bump_version
    Versioner.call(options)
  end
end
