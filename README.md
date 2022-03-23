# Posterr
 
It’s a RESTfull API to solve the proposal problem describe below.

### Proposal Problem

The Project Manager you work with wants to build a new product, a new social media application called Posterr. Posterr is very similar to Twitter, but it has far fewer features.
Posterr only has two pages, the homepage and the user profile page, which are described below. Other data and actions are also detailed below.

## Deps for Linux

- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install -y build-essential libssl-dev zlib1g-dev automake autoconf libncurses5-dev`

## In loco Setup

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`
- Run complete tests `mix test`

## Database
  PostgreSQL
  ```
  username: postgres
  password: postgres
  ```

## Using

 You can use postman, or a similar app, to send json to this API.

### Endpoint

 - Create User ( post /api/users )
  ```
  {
    "user": {
      username: "YOUR_NAME_PLZ"
    }
  }
  ```

## Planning
 WIP
## Critique
 WIP
## Made by

 - [mavmaso](https://github.com/mavmaso)
