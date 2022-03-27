defmodule Posterr.Factory do
  use ExMachina.Ecto, repo: Posterr.Repo

  use Posterr.FollowingFactory
  use Posterr.UserFactory
  use Posterr.PostFactory
end
