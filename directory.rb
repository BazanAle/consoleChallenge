class Directory
attr_reader :name, :parent_directory

  def initialize(name, parent_directory=nil)
  @name = name
  @parent_directory = parent_directory
  @files = []
  @folders = []
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

end