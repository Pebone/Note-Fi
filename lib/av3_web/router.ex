defmodule Av3Web.Router do
  use Av3Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Av3Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Av3Web do
    pipe_through :browser

    get "/", PageController, :index

    get "/users", UserController, :index
    get "/users/new", UserController, :new
    get "/users/edit/:id", UserController, :edit

    get "/revenue", RevenueController, :index
    get "/revenue/new", RevenueController, :new
    get "/revenue/edit/:id", RevenueController, :edit
    post "/revenue/create", RevenueController, :create
    put "/revenue/update", RevenueController, :update
    get "/revenue/delete/:id", RevenueController, :delete

    get "/expense", ExpenseController, :index
    get "/expense/new", ExpenseController, :new
    get "/expense/edit/:id", ExpenseController, :edit
    post "/expense/create", ExpenseController, :create
    put "/expense/update", ExpenseController, :update
    get "/expense/delete/:id", ExpenseController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Av3Web do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Av3Web.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
