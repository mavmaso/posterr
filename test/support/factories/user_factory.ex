defmodule Posterr.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Posterr.Accounts.User{
          username: "nome_do_users#{System.unique_integer([:positive])}"
        }
      end
    end
  end
end
