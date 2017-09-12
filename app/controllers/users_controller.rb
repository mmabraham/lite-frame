class UsersController < ControllerBase
  def index
    @users = ['John Doe', 'Jane Smith', 'Jack Brown']
    render 'index'
  end

  def show
    render_content "You have selected number #{params['id']}"
  end
end
