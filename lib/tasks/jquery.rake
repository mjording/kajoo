require 'net/http'
require 'uri'

namespace :jquery do
  task :update do
    http = Net::HTTP.new("code.jquery.com")
    http.start do |http|
        resp = http.get("/jquery-latest.min.js")
        open("public/javascripts/jquery.js", "wb") do |file|
            file.write(resp.body)
        end
    end

    http = Net::HTTP.new("github.com", 443)
    http.use_ssl = true
    http.start do |http|
        http.use_ssl = true
        resp = http.get("/rails/jquery-ujs/raw/master/src/rails.js")
        open("public/javascripts/rails.js", "wb") do |file|
            file.write(resp.body)
        end
    end

    puts "Updated jQuery and Rails jQuery drivers!"
  end
end
