class AttackFile
  ATTACKS_DIR = File
                .expand_path('../../attacks', __dir__)
                .freeze
  TEMPLATE_FILE = File.join(ATTACKS_DIR, 'manual-adhoc-query.attack')

  # TODO: add guards, proper logic, maybe db storage
  def self.write(filename, body)
    path = self.file_path(name)
    File.write(path, body)
  end

  def self.destroy(filename)
    path = self.file_path(name)
    File.delete(path) if File.exist?(path)
  end

  def self.create(params)
    file = File.read(TEMPLATE_FILE)
    file.gsub!("NAME", params[:name])
    file.gsub!("NODE", Node.find(params[:node_id]).node_key)
    file.gsub!("QUERY", params[:query])
    file.gsub!("OUTPUT", params[:output])
    file_name = File.join(ATTACKS_DIR, "#{params[:name]}.attack")

    File.write(file_name, file)
  end

  def self.attack_files
    Dir
      .entries(ATTACKS_DIR)
      .reject { |e| File.directory?(e) }
  end

  def self.file_path(file_name)
    File.join(ATTACKS_DIR, file_name)
  end

  def self.contents(file_name)
    name = file_name.ends_with?('.attack') ? file_name : file_name + '.attack'

    path = self.file_path(name)
    File.read(path)
  end
end
