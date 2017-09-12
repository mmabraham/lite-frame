require 'json'
require 'byebug'

class Session
  def initialize(req)
    @cookie = JSON.parse(req.cookies['_lite_frame_app'] || '{}' )
  end

  def [](key)
    cookie[key]
  end

  def []=(key, val)
    cookie[key] = val
  end

  def store_session(res)
    res.set_cookie('_lite_frame_app', cookie.to_json)
  end
  private
  attr_reader :cookie
end
