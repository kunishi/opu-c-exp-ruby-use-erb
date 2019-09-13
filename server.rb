#!/usr/bin/ruby
require 'webrick'
require 'csv'
require 'erb'

books = CSV.open("books.csv")
erb = ERB.new(File.read("all.erb"))

server = WEBrick::HTTPServer.new(
  :Port => 8080,
  :DocumentRoot => File.join(Dir.pwd, "public_html")
)
server.mount_proc("/all") { |req, res|
  res.content_type = "text/html"
  res.body = erb.result(binding)
}
server.mount_proc("/now") { |req, res|
  res.body = Time.now.to_s
}

Signal.trap(:INT) { server.shutdown }
server.start
