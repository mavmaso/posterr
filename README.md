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
  `http://localhost:4000`

 - Create User ( post /api/users )
  ```
  {
    "user": {
      "username": "name bigger than 13 chars"
    }
  }
  ```

 - Show User (get /api/users/:id )

 - Index User (get /api/users )

 - Follow user ( post /api/follow )
  ```
  {
    "user_id": 1,
    "follow_id": 2
  }
  ```

 - Create Post (post /api/posts/ )
  ```
  {
    "post": {
      "content": "text between 1 to 777",
      "type": "original",
      "user_id": 1
    }
  }
  ```

 - Index all Post (get /api/posts?page=:page )

 - Index followings Post (get /api/posts?page=:page&user_id=:user_id )

 - Index Post (get /api/user_posts?page=:page&user_id=:user_id )


## Planning
 I didn't really catch the difference between reply-to-post and quote-post, don't they both have a post as a basis and reply to it ? Or would it be something more like a thread following an original and several replies following ?  If so, you can make a one to one relationship, where the oldest post always leads to the same new one forming a thread to be followed by a "show more" button to deliver it.

## Critique
 If I had more time I would:
- login system and with that delivered "show user" with a feature to see if he is following or not
- @spec in all functions
- installed credo, bester test cover, among other improvements to have a production-ready software.

For being a Twitter clone project I would have seen to use a NoSQL database because there are not many models to relate to but a lot of data.

## Made by

 - [mavmaso](https://github.com/mavmaso)
