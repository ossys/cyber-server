class AttackFile
  ATTACKS_DIR = File
                .expand_path('../../attacks', __dir__)
                .freeze
  TEMPLATE_FILE = File.join(ATTACKS_DIR, 'manual-adhoc-query.attack')

  def self.create(params)
    file = File.read(TEMPLATE_FILE)
    file.gsub!("NAME", params[:name])
    file.gsub!("NODE", Node.find(params[:node_id]).node_key)
    file.gsub!("QUERY", params[:query])
    file.gsub!("OUTPUT", params[:output])
    file_name = File.join(ATTACKS_DIR, "#{params[:name]}.attack")

    File.write(file_name, file)
  end
end
