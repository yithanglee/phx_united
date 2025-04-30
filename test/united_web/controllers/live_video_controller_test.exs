defmodule UnitedWeb.LiveVideoControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{created_at: ~N[2010-04-17 14:00:00], description: "some description", embed_html: "some embed_html", facebook_page_id: 42, live_id: "some live_id", picture: "some picture", title: "some title"}
  @update_attrs %{created_at: ~N[2011-05-18 15:01:01], description: "some updated description", embed_html: "some updated embed_html", facebook_page_id: 43, live_id: "some updated live_id", picture: "some updated picture", title: "some updated title"}
  @invalid_attrs %{created_at: nil, description: nil, embed_html: nil, facebook_page_id: nil, live_id: nil, picture: nil, title: nil}

  def fixture(:live_video) do
    {:ok, live_video} = Settings.create_live_video(@create_attrs)
    live_video
  end

  describe "index" do
    test "lists all live_videos", %{conn: conn} do
      conn = get(conn, Routes.live_video_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Live videos"
    end
  end

  describe "new live_video" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.live_video_path(conn, :new))
      assert html_response(conn, 200) =~ "New Live video"
    end
  end

  describe "create live_video" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.live_video_path(conn, :create), live_video: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.live_video_path(conn, :show, id)

      conn = get(conn, Routes.live_video_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Live video"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.live_video_path(conn, :create), live_video: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Live video"
    end
  end

  describe "edit live_video" do
    setup [:create_live_video]

    test "renders form for editing chosen live_video", %{conn: conn, live_video: live_video} do
      conn = get(conn, Routes.live_video_path(conn, :edit, live_video))
      assert html_response(conn, 200) =~ "Edit Live video"
    end
  end

  describe "update live_video" do
    setup [:create_live_video]

    test "redirects when data is valid", %{conn: conn, live_video: live_video} do
      conn = put(conn, Routes.live_video_path(conn, :update, live_video), live_video: @update_attrs)
      assert redirected_to(conn) == Routes.live_video_path(conn, :show, live_video)

      conn = get(conn, Routes.live_video_path(conn, :show, live_video))
      assert html_response(conn, 200) =~ "some updated live_id"
    end

    test "renders errors when data is invalid", %{conn: conn, live_video: live_video} do
      conn = put(conn, Routes.live_video_path(conn, :update, live_video), live_video: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Live video"
    end
  end

  describe "delete live_video" do
    setup [:create_live_video]

    test "deletes chosen live_video", %{conn: conn, live_video: live_video} do
      conn = delete(conn, Routes.live_video_path(conn, :delete, live_video))
      assert redirected_to(conn) == Routes.live_video_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.live_video_path(conn, :show, live_video))
      end
    end
  end

  defp create_live_video(_) do
    live_video = fixture(:live_video)
    %{live_video: live_video}
  end
end
