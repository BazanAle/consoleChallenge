require_relative "controller"


class Consola

  def initialize
  @controller = Controller.new
  @running = true
  end  

  def run
    while @running
      input = gets.chomp
      parts = input.split(" ")
      command=parts[0]
      args = parts[1..]
      actions(command, args)
    end
  end
  
  def actions(comand, args)
    case comand
    when "create_file"
       @controller.create_file(args[0], args[1])
    when "show"
      @controller.show(args[0])
    when "metadata"
      @controller.metadata(args[0])
    when "create_folder"
      @controller.create_folder(args[0])
    when "cd"
      @controller.cd(args[0])
    when "destroy"
      @controller.destroy(args[0])
    when "ls"
      @controller.ls
    when "whereami"
      @controller.whereami
    when 'exit'
      @running = false
    end
  
  end

end

Consola.new.run

#Crear archivo con contenido(create_file file_1 "Contenido")

#Ver contenido de un archivo(show file_1)

#Ver metadata del archivo(metadata file_1)

#Crear una carpeta(create_folder folder_1)

#Entrar a una carpeta(cd folder_1)


#Volver una carpeta para atras(cd ..)

#Eliminar un archivo o carpeta(destroy file_1, destroy folder_1)

#Ver contenido de carpeta actual(ls)

#Obtener la ruta de la carpeta actual(whereami)
