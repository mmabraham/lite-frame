require 'rack'
require_relative 'router'
require_relative 'controller_base'

Dir.new('controllers')
  .each { |f| require_relative "controllers/#{f}" unless f[0] == '.'}

def router
  @router ||= Router.new
end
load 'routes.rb'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

case ARGV[0]
  when 'server'
    Rack::Server.start(
      app: app,
      Port: ARGV[1] || 3000
    )
end
