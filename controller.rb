require_relative "file"
require_relative "directory"
class Controller

  attr_reader :current_directory
  def initialize
    @current_directory = Directory.new("/")

  end

#Crear archivo con contenido(create_file file_1 "Contenido")
  def create_file(file_name, content)
    file = File.new(file_name, content)
    @current_directory.add_file(file)
  end
#Ver contenido de un archivo(show file_1)
  def show (file_name)
    puts @current_directory.find(file_name).content
  end

#Ver metadata del archivo(metadata file_1)
  def metadata(file_name)
    puts @current_directory.find(file_name).metadata
  end

#Crear una carpeta(create_folder folder_1)
  def create_folder(folder_name)
  folder = Directory.new(folder_name, current_directory)
  @current_directory.add_folder(folder)
  end

#Entrar a una carpeta(cd folder_1)
#Volver una carpeta para atras(cd ..)
  def cd(folder_name)
    if folder_name == '..'
      if @current_directory.parent_directory.nil?
        puts 'Esta es la ruta principal'
      else
        @current_directory = @current_directory.parent_directory
      end
    else
      folder = @current_directory.find_folder(folder_name)
      if folder 
        @current_directory = folder
      else
        puts 'Nombre de carpeta no existe'
      end
    end
  end

#Eliminar un archivo o carpeta(destroy file_1, destroy folder_1)
  def destroy(name)
    file = @current_directory.find(name)
    folder =@current_directory.find_folder(name)
    if file
    @current_directory.remove_file(file)
      puts "Se ha eliminado el file #{file.name}"
    elsif folder
      @current_directory.remove_folder(folder)
      puts "Se ha eliminado la carpeta #{folder.name}"
    else
      puts 'No existe ni archivo ni carpeta con el nombre ingresado'
  end
    
  end
#Ver contenido de carpeta actual(ls)
def ls
  @current_directory.list_files
end

#Obtener la ruta de la carpeta actual(whereami)
def whereami
  @current_directory.path
end

end

