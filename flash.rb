require 'json'

class Flash
  attr_reader :now
  def initialize(req)
    @current_cookie = {}
    @prev_cookie = JSON.parse(req.cookies['_rails_lite_app_flash'] || '{}' )
    @now = {}
  end

  def now
    @now
  end

  def [](key)
    now[key] || current_cookie[key.to_s] || prev_cookie[key.to_s]
  end

  def []=(key, val)
    current_cookie[key.to_s] = val
  end

  def store_flash(res)
    res.set_cookie(
      '_rails_lite_app_flash', value: current_cookie.to_json, path: '/'
    )
  end
  private
  attr_reader :current_cookie, :prev_cookie
end
