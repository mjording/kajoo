SITE = YAML.load_file("#{Rails.root}/config/#{ENV['KAJOO_NODE'] ? ENV['KAJOO_NODE']+'_' : ''}site.yml")[Rails.env]
ZIPS = YAML.load_file("#{Rails.root}/config/#{ENV['KAJOO_NODE'] ? ENV['KAJOO_NODE']+'_' : ''}zips.yml")
