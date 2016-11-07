APP_CONFIG = YAML.load_file('config/application.yml')[Rails.env].with_indifferent_access
