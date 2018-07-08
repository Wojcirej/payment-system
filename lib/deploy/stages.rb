module Stages

  def stages
    ["staging", "production"]
  end

  def valid_stage?(stage)
    stages.include?(stage)
  end
end
