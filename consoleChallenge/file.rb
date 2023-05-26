require "csv"

class File
  attr_reader :name, :content, :metadata

  def initialize(name, content, metadata = nil)
    @name = name
    @content = content
    @metadata = metadata || "Nombre: #{name} / Empresa: ShipNow"
  end
end
