# Posterr
 
It’s a RESTfull API to

### Proposal Problem

  

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
    "": {

    }
  }
  ```

## Made by

 - [mavmaso](https://github.com/mavmaso)
