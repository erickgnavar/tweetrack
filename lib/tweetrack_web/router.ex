defmodule TweetrackWeb.Router do
  use TweetrackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TweetrackWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/searches", SearchController
    get "/searches/:id/start", SearchController, :start
    get "/searches/:id/finish", SearchController, :finish
  end

  scope "/api/v1", TweetrackWeb do
    pipe_through :api

    get "/tweets", TweetController, :index
    get "/tweets/:id", TweetController, :show

    get "/searches/:search_id/tweets", TweetController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TweetrackWeb do
  #   pipe_through :api
  # end
end
