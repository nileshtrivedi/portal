# Studio

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

users(did, metadata) -- include booleans/username in the id or tags

fields(scope, id, name, color, type, is_required)


portals(id, display_name, type, slug, parent_id, fields) -- type = container, posts, events, chat, course, members
members(user_id, portal_id, is_active, role, fields)

-- access and visibility are two different things
permissions(scope, action, criteria)

posts(id, type, space_id, user_id, parent_id, data, timestamp, fields) -- post can have attachments

automations(scope, event_trigger, workflow) -- example welcome message
paywalls() / affiliates()