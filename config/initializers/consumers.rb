Rails.configuration.x.consumers_configuration =
  Pathname.new('config/consumers.yml')
    .yield_self { |path| ERB.new(path.read).result }
    .yield_self { |file| YAML.load(file).deep_symbolize_keys }
