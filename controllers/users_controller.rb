class UsersController < ControllerBase
  def index
    render 'index'
  end

  def show
    render_content "--- SHOW --- #{params['id']}"
  end
end
