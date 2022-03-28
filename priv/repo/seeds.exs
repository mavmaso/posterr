alias Posterr.Accounts
alias Posterr.Blog

{:ok, user} = Accounts.create_user(%{username: "User number one"})
Accounts.create_user(%{username: "User number two"})

Blog.create_post(%{user_id: user.id, content: "primo", type: "original"})
