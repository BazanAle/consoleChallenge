require "csv"
require_relative "file"
require_relative "directory"
require_relative "user"

class Controller

  attr_reader :current_directory, :current_user  
  def initialize
    @current_directory = Directory.new("/")
    @current_user = nil
    @users = []
  end

#Crear archivo con contenido(create_file file_1 "Contenido")
  def create_file(file_name, content)
    file = File.new(file_name, content)
    @current_directory.add_file(file)
  end
#Ver contenido de un archivo(show file_1)
  def show (file_name)
    if @current_directory.find(file_name)
    puts @current_directory.find(file_name).content
    else
      puts "No existe archivo con el nombre ingresado para mostrar el contenido."
    end
  end

#Ver metadata del archivo(metadata file_1)
  def metadata(file_name)
    if @current_directory.find(file_name)
    puts @current_directory.find(file_name).metadata
    else
      puts "No existe archivo con el nombre ingresado para mostrar metadata."
    end
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
     puts  "Está seguro de que desea eliminar el archivo #{file.name}? (Y/N)"
     input = gets.chomp 
      if input == "Y" || input == "y"
        @current_directory.remove_file(file)
        puts "Se ha eliminado el file #{file.name}"
      else
        puts ""
      end
   elsif folder
    puts  "Está seguro de que desea eliminar la carpeta #{folder.name}? (Y/N)"
    input = gets.chomp 
    if input == "Y" || input == "y"
      @current_directory.remove_folder(folder)
      puts "Se ha eliminado la carpeta #{folder.name}"
     else
      puts ""
     end
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

#Crear un usuario nuevo con su password
  def create_user(username, password)
    user = User.new(username, password)
    @current_user = user
    @users << user
    puts "Usuario creado exitosamente."
    
  end

#Loguearte como usuario
  def login(username, password)
    user = @users.find{|user| user.user_name == username}
    if user
      if user.authenticate(password)
        puts "Usuario logueado correctamente."
        @current_user = user
      else
        puts "Password incorrecto."
      end
    else
      puts "Usuario inexistente."
    end
  end
#Ver username actual

  def whoami
    if @current_user
    puts "El usuario actual es #{@current_user.user_name}."
    else
    puts "No existe usuario logueado."
    end
  end

  #Mejora: Logout
  def logout
    if @current_user
      puts "El usuario #{@current_user.user_name} ha sido deslogueado."
      @current_user = nil
    else
      puts "No existe usuario logueado."  
    end
  end

 def load_data
 @current_directory.load_from_file
 @current_directory.load_from_folder
 end
end

