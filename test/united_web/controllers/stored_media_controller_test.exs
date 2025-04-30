defmodule UnitedWeb.StoredMediaControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{
    f_extension: "some f_extension",
    f_type: "some f_type",
    name: "some name",
    s3_url: "some s3_url",
    size: 42
  }
  @update_attrs %{
    f_extension: "some updated f_extension",
    f_type: "some updated f_type",
    name: "some updated name",
    s3_url: "some updated s3_url",
    size: 43
  }
  @invalid_attrs %{f_extension: nil, f_type: nil, name: nil, s3_url: nil, size: nil}

  def fixture(:stored_media) do
    {:ok, stored_media} = Settings.create_stored_media(@create_attrs)
    stored_media
  end

  describe "index" do
    test "lists all stored_medias", %{conn: conn} do
      conn = get(conn, Routes.stored_media_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stored medias"
    end
  end

  describe "new stored_media" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stored_media_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stored media"
    end
  end

  describe "create stored_media" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stored_media_path(conn, :create), stored_media: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stored_media_path(conn, :show, id)

      conn = get(conn, Routes.stored_media_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stored media"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stored_media_path(conn, :create), stored_media: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stored media"
    end
  end

  describe "edit stored_media" do
    setup [:create_stored_media]

    test "renders form for editing chosen stored_media", %{conn: conn, stored_media: stored_media} do
      conn = get(conn, Routes.stored_media_path(conn, :edit, stored_media))
      assert html_response(conn, 200) =~ "Edit Stored media"
    end
  end

  describe "update stored_media" do
    setup [:create_stored_media]

    test "redirects when data is valid", %{conn: conn, stored_media: stored_media} do
      conn =
        put(conn, Routes.stored_media_path(conn, :update, stored_media),
          stored_media: @update_attrs
        )

      assert redirected_to(conn) == Routes.stored_media_path(conn, :show, stored_media)

      conn = get(conn, Routes.stored_media_path(conn, :show, stored_media))
      assert html_response(conn, 200) =~ "some updated f_extension"
    end

    test "renders errors when data is invalid", %{conn: conn, stored_media: stored_media} do
      conn =
        put(conn, Routes.stored_media_path(conn, :update, stored_media),
          stored_media: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Stored media"
    end
  end

  describe "delete stored_media" do
    setup [:create_stored_media]

    test "deletes chosen stored_media", %{conn: conn, stored_media: stored_media} do
      conn = delete(conn, Routes.stored_media_path(conn, :delete, stored_media))
      assert redirected_to(conn) == Routes.stored_media_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.stored_media_path(conn, :show, stored_media))
      end
    end
  end

  defp create_stored_media(_) do
    stored_media = fixture(:stored_media)
    %{stored_media: stored_media}
  end
end
