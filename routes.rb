router.draw do
  get Regexp.new("^/users$"), UsersController, :index
  get Regexp.new("^/users/(?<id>\\d+)$"), UsersController, :show
end
