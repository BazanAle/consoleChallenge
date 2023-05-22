require "date"

class File
attr_reader :name, :content, :metadata

  def initialize(name,content)
    @name = name
    @content = content
    @metadata = "Nombre: #{name} / Empresa: ShipNow / Fecha #{Date.today}"
  end

end
