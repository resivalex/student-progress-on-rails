module NameDescriptionApiConvertion
  def to_api
    {
      id: id,
      name: name,
      description: description
    }
  end

  def from_api data
    send :name=, data[:name]
    send :description=, data[:description]
    self
  end
end