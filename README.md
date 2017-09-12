## lite-frame

#### lite-frame is a light-weight controller and view web framework modeled after rails. It's API is designed to be intuitive to anyone who has used rails while using less than kb of memory.

<!--
# implementation -->

# usage
all application code is written in the app folder

## routes
routes are defined in `app/routes.rb`

`routes.draw` is passed a block that has access to methods aliased as the common HTTP methods. To define a route, call the method with 3 arguments.
1- a regex to match against the url.
2- the controller that will handle that route.
3- a symbol representing the controller action.

example:
```ruby
# app/routes.rb

router.draw do
  get /^\/users$/, UsersController, :index
  get /^\/users\/(?<id>\d+)$/, UsersController, :show
end
```

## controllers
Controllers should inherit from `ControllerBase` and should be placed in the `app/controllers` directory. File names should be the snake-cased version of the controller class name, and should be suffixed with `_controller.rb`.

example:
```ruby
# app/controllers/users_controller.rb

class UsersController < ControllerBase
  def index
    @users = ['John Doe', 'Jane Smith', 'Jack Brown']
    render 'index'
  end

  def show
    render_content "You have selected number #{params['id']}"
  end
end
```
 ### instance methods
 The following instance methods are available within controllers:

`#redirect_to(url)`
Redirects to the specified URL

`#render_content(content, [content_type])`
Renders content of the specified type. (default is html)

`#render(template_name)`
Renders the specified erb template

`#session`
A hash-like object that stores data in the app's session cookie

`#flash`
For persisting data for a single request-response cycle

## views

Views are written in erb. The folder and file names should match that of the corresponding controller and action.

example:
```html
# app/views/users/index.html.erb

<h1>Users</h1>
<ul>
  <% @users.each do |user| %>
    <li><%= user %></li>
  <% end %>
</ul>

```
