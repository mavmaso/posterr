defmodule Posterr.PostFactory do
  defmacro __using__(_opts) do
    quote do
      def post_factory do
        %Posterr.Blog.Post{
          type: :original,
          content: "muita coisa aqui",
          user: build(:user)
        }
      end
    end
  end
end
