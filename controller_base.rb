require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  def initialize(req, res, params = {})
    @params = req.params.merge(params)
    @req = req
    @res = res
  end

  def redirect_to(url)
    prevent_double_render!

    @res['Location'] = url
    @res.status = 302
    session.store_session(@res)
    flash.store_flash(@res)
  end

  def render_content(content, content_type = 'text/html')
    prevent_double_render!
    @res['Content-Type'] = content_type
    @res.write(content)

    session.store_session(@res)
    flash.store_flash(@res)
  end

  def render(template_name)
    path = "views/" +
      self.class.to_s.underscore.sub('_controller', '') +
      "/#{template_name}.html.erb"

    erb_string = File.read(path)
    html_string = ERB.new(erb_string).result(binding)
    render_content(html_string, 'text/html')
  end

  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  private
  def already_built_response?
    @already_built_response
  end

  def prevent_double_render!
    if already_built_response?
      raise DoubleRenderError.new('you can\'t render twice')
    end
    @already_built_response = true
  end
end

class DoubleRenderError < StandardError
end
