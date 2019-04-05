require './lib/version'
require './lib/deploy/stages'
class Versioner
  include Stages

  def initialize(options)
    @options = options
    @bump_type = options[:bump]
    @current_version = ::PaymentSystemBackend::VERSION
    @new_version = nil
  end

  def self.call(bump_type)
    new(bump_type).call
  end

  def call
    bump_number
    change_version_file
    commit_new_version_number
    push_new_version_number
    set_version_tag
    push_tag
  end

  private
  attr_reader :options, :bump_type, :current_version
  attr_accessor :new_version

  def bump_number
    splitted = current_version.split(".")
    case bump_type
    when :patch
      splitted[2] = splitted[2].to_i + 1
    when :minor
      splitted[1] = splitted[1].to_i + 1
      splitted[2] = "0"
    when :major
      splitted[0] = splitted[0].to_i + 1
      splitted[1] = "0"
      splitted[2] = "0"
    end
    self.new_version = splitted.join(".")
  end

  def change_version_file
    File.open("./lib/version.rb", "w") do |file|
      file.write(version_file_template)
    end
  end

  def version_file_template
    content = <<EOF
module PaymentSystemBackend
  VERSION = "#{new_version}"
end
EOF
    return content
  end

  def commit_new_version_number
    unless new_version
      puts("Version not bumped yet - aborting!")
      return
    end
    system(commit_new_version_number_command)
  end

  def commit_new_version_number_command
    "git commit -am \"v#{new_version}\""
  end

  def push_new_version_number
    unless new_version
      puts("Version not bumped yet - aborting!")
      return
    end
    system(push_new_version_number_command)
  end

  def push_new_version_number_command
    "git push origin develop"
  end

  def set_version_tag
    unless new_version
      puts("Version not bumped yet - aborting!")
      return
    end
    system(set_version_tag_command)
  end

  def set_version_tag_command
    "git tag -a v#{new_version} -m\"v#{new_version}\""
  end

  def push_tag
    unless new_version
      puts("Version not bumped yet - aborting!")
      return
    end
    system(push_tag_command)
  end

  def push_tag_command
    "git push origin v#{new_version}"
  end
end
