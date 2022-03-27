defmodule SnippexWeb.SnippetsController do
  use SnippexWeb, :controller


  def create(conn, %{}) do
    send_resp(conn, 200, "created")
  end
end