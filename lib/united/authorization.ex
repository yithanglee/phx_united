defmodule United.Authorization do
  use Phoenix.Controller, namespace: UnitedWeb
  import Plug.Conn
  require IEx

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    if conn.request_path |> String.contains?("/admin") do
      if conn.private.plug_session["current_user"] == nil do
        cond do
          conn.request_path |> String.contains?("/login") ->
            conn

          conn.request_path |> String.contains?("/logout") ->
            conn

          conn.request_path |> String.contains?("/authenticate") ->
            conn

          true ->
            conn
            |> put_flash(:error, "You haven't login.")
            |> redirect(to: "/admin/login")
            |> halt
        end
      else
        conn
      end
    else
      if conn.request_path |> String.contains?("/0") do
        conn
        |> put_flash(:error, "Unauthorized.")
        |> redirect(to: "/admin")
        |> halt
      else
        conn
      end
    end
  end
end

defmodule United.ApiAuthorization do
  use Phoenix.Controller, namespace: UnitedWeb
  import Plug.Conn
  require IEx

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    # IO.inspect(conn)
    if conn.method == "POST" || conn.method == "OPTIONS" do
      cond do
        conn.params["scope"] in [
          "sign_in",
          "google_signin",
          "strong_search"
        ] ->
          conn

        # Plug.Conn.get_req_header(conn, "phx-request") != [] ->
        #   conn

        true ->
          with auth_token <- Plug.Conn.get_req_header(conn, "authorization") |> List.first(),
               true <- auth_token != nil,
               token <- auth_token |> String.split("Basic ") |> List.last(),
               t <- United.Settings.decode_member_token2(token),
               admin_t <-
                 United.Settings.decode_admin_token(token)
                 |> IO.inspect() do
            if t != nil do
              conn
            else
              if admin_t != nil do
                conn
              else
                IO.inspect("not auth, no admin token")

                conn
                |> resp(403, Jason.encode!(%{message: "Not authorized."}))
                |> halt
              end
            end
          else
            _ ->
              IO.inspect("not auth, no auth header?")

              conn
              |> resp(403, Jason.encode!(%{message: "Not authorized."}))
              |> halt
          end
      end
    else
      conn
    end
  end
end
