defmodule PubsubTutorialExcerciseWeb.PageController do
  use PubsubTutorialExcerciseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
