require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue StandardError => e
    ['500', {'Content-Type' => 'text/html'}, [render_exception(e)]]
  end

  private

  def render_exception(error)
    @error = error
    filename, line_num = error.backtrace[0].split(':')
    @line_num = line_num.to_i
    @lines = File.readlines(filename)
    erb_string = File.read('app/views/layouts/error.html.erb')
    ERB.new(erb_string).result(binding)
  end
end
