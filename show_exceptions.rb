require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue StandardError => e
    res = Rack::Response.new
    res.status = '500'
    res.write(render_exception(e))
    res.finish
  end

  private

  def render_exception(e)
    "#{e.message}\n#{error_lines(e)}\n#{e.backtrace.join("\n")}"
  end

  def error_lines(error)
    filename, line = error.backtrace[0].split(':')
    File.readlines(filename)[line.to_i - 3, 6].join
  end

end
