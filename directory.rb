require "csv"
require_relative "file"

class Directory
attr_reader :name, :parent_directory
attr_accessor :persistence_file, :persistence_folder

  def initialize(name, parent_directory=nil)
  @name = name
  @parent_directory = parent_directory
  @files = []
  @folders = []

  @persistence_file = File.join(__dir__, "files.csv")
  @persistence_folder = File.join(__dir__, "folders.csv")

  end

  def add_file(file)
    @files << file
   # save_to_file
  end

  def add_folder(folder)
    @folders << folder
   # save_to_folder
  end

  def find(file_name)
     @files.find { |file| file.name == file_name }  
  end

  def find_folder(folder_name)
    @folders.find { |folder| folder.name == folder_name }  
  end

  def remove_file(file)
    @files.delete(file)
  end
  def remove_folder(folder)
    @folders.delete(folder)
  end

  def list_files
    puts "carpetas: [#{@folders.count}]" 
    @folders.each { |folder| puts " >> #{folder.name}"}

    puts "files: [#{@files.count}]"
    @files.each {|file| puts "> #{file.name}" }
  end

  def path
    if @parent_directory.nil?
      puts @name
    else
      while @parent_directory != nil
        @name = "#{@parent_directory.name}/#{@name}"
        @parent_directory = @parent_directory.parent_directory
      end
      puts @name
    end
  end

  def load_from_file
    files = CSV.parse(File.read(@persistence_file))
    files.each do |file|
      name = file[0]
      content = file[1]
      metadata = file[2]
      @files << File.new(name, content, metadata)
    end
  end

  def load_from_folder
    folders = CSV.parse(File.read(@persistence_folder))
    folders.each do |folder|
      array_folder = folder.pop.split(",")
      name = array_folder[0]
      if array_folder[1].split("/").pop.nil?
        parent_directory = Directory.new("/")
      else
        folders_pd = array_folder[1].split("/").reject(&:empty?).compact
        folders_pd.each_with_index do |folder, index|
          if index == 0
            parent_directory = Directory.new(folder)
          else
            parent_directory = Directory.new(folder, Directory.new(folders_pd[index-1]))
          end 
        end
      end     
      @folders << Directory.new(name, parent_directory)
    end
    p @folders
  end
 
  def save_to_file
    puts @persistence_file
    puts @files

    CSV.open(@persistence_file, "wb", encoding: 'ISO-8859-1:UTF-8') do |csv|
      csv << ['Nombre', 'Contenido', 'Metadatos']  # Escribir encabezados de columna
  
      @files.each do |file|
        csv << [file.name, file.content, file.metadata]  # Escribir una fila de valores
      end
    end
  end
  


def save_to_folder
    data = []
    @folders.each do |folder|
      p folder.parent_directory.name
      directory = "#{folder.parent_directory.name}/#{folder.name}"

      p folder.name
      p directory
      data << "#{folder.name}, #{directory}"  # Agregar datos al arreglo
    end
    p data.flatten
    File.write(@persistence_folder, data)
  end
  

end