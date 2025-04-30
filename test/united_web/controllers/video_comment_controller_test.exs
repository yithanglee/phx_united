defmodule UnitedWeb.VideoCommentControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{created_at: ~N[2010-04-17 14:00:00], message: "some message", ms_id: "some ms_id", page_visitor_id: 42}
  @update_attrs %{created_at: ~N[2011-05-18 15:01:01], message: "some updated message", ms_id: "some updated ms_id", page_visitor_id: 43}
  @invalid_attrs %{created_at: nil, message: nil, ms_id: nil, page_visitor_id: nil}

  def fixture(:video_comment) do
    {:ok, video_comment} = Settings.create_video_comment(@create_attrs)
    video_comment
  end

  describe "index" do
    test "lists all video_comments", %{conn: conn} do
      conn = get(conn, Routes.video_comment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Video comments"
    end
  end

  describe "new video_comment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.video_comment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Video comment"
    end
  end

  describe "create video_comment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.video_comment_path(conn, :create), video_comment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.video_comment_path(conn, :show, id)

      conn = get(conn, Routes.video_comment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Video comment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.video_comment_path(conn, :create), video_comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Video comment"
    end
  end

  describe "edit video_comment" do
    setup [:create_video_comment]

    test "renders form for editing chosen video_comment", %{conn: conn, video_comment: video_comment} do
      conn = get(conn, Routes.video_comment_path(conn, :edit, video_comment))
      assert html_response(conn, 200) =~ "Edit Video comment"
    end
  end

  describe "update video_comment" do
    setup [:create_video_comment]

    test "redirects when data is valid", %{conn: conn, video_comment: video_comment} do
      conn = put(conn, Routes.video_comment_path(conn, :update, video_comment), video_comment: @update_attrs)
      assert redirected_to(conn) == Routes.video_comment_path(conn, :show, video_comment)

      conn = get(conn, Routes.video_comment_path(conn, :show, video_comment))
      assert html_response(conn, 200) =~ "some updated ms_id"
    end

    test "renders errors when data is invalid", %{conn: conn, video_comment: video_comment} do
      conn = put(conn, Routes.video_comment_path(conn, :update, video_comment), video_comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Video comment"
    end
  end

  describe "delete video_comment" do
    setup [:create_video_comment]

    test "deletes chosen video_comment", %{conn: conn, video_comment: video_comment} do
      conn = delete(conn, Routes.video_comment_path(conn, :delete, video_comment))
      assert redirected_to(conn) == Routes.video_comment_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.video_comment_path(conn, :show, video_comment))
      end
    end
  end

  defp create_video_comment(_) do
    video_comment = fixture(:video_comment)
    %{video_comment: video_comment}
  end
end
