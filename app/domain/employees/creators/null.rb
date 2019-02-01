class Employees::Creators::Null

  def self.call(params)
    return Employee.create(params)
  end
end
