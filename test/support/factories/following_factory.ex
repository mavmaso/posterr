defmodule Posterr.FollowingFactory do
  defmacro __using__(_opts) do
    quote do
      def following_factory do
        %Posterr.Accounts.Following{
          user: build(:user),
          follow: build(:user)
        }
      end
    end
  end
end
