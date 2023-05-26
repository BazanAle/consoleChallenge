require "csv"
require_relative "file"

class Directory
attr_reader :name, :parent_directory
attr_accessor :persistence_file, :persistence_folder

  def initialize(name, parent_directory=nil,persistence_file = nil, persistence_folder = nil)
  @name = name
  @parent_directory = parent_directory
  @files = []
  @folders = []

  @csv = persistence_file
  @persistence_folder = persistence_folder
 # load_from_file if @persistence_file
 # load_from_folder if @persistence_folder
 p  @persistence_file
 p  @persistence_folder

  end

  def add_file(file)
    @files << file
  end

  def add_folder(folder)
    @folders << folder
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
    CSV.foreach(@persistence_file) do |row|
      name = row[0]
      content = row[1]
      metadata = row[2]
      @files << File.new(name, content, metadata)
    end
  end

  def load_from_folder
    CSV.foreach(@persistence_folder) do |row|
      name = row[0]
      parent_directory = row[1]
      @folders << Directory.new(name, parent_directory)
    end
  end
  def save_to_file
    CSV.open("/home/nataliagatti/Alejandro/consoleChallenge/persistence_folder.csv", "w") do |csv|
      csv << ['Columna 1', 'Columna 2', 'Columna 3']  # Escribir encabezados de columna
  csv << ['Valor 1', 'Valor 2', 'Valor 3']        # Escribir una fila de valores
  # Puedes agregar más filas según sea necesario
end
  end
  
  
  def save_to_folder
    CSV.open(@persistence_folder, "wb") do |csv|
      @folders.each do |folder|
        csv << [folder.name, folder.parent_directory]
      end
    end
  end
  

end