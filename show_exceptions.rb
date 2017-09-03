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
    lines(e)
    e.backtrace
    "#{e.message}
      #{lines(e)}
      #{e.backtrace.join("\n")}"
  end

  def lines(error)
    filename, line = error.backtrace[0].split(':')
    File.readlines(filename)[line.to_i - 5, 8].join
  end

end
