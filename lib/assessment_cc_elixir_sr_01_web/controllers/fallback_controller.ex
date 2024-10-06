defmodule AssessmentCcElixirSr01Web.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use AssessmentCcElixirSr01Web, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(AssessmentCcElixirSr01Web.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
