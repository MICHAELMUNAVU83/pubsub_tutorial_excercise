defmodule PubsubTutorialExcerciseWeb.BlogLive.Index do
  use PubsubTutorialExcerciseWeb, :live_view

  alias PubsubTutorialExcercise.Blogs
  alias PubsubTutorialExcercise.Blogs.Blog

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Blogs.subsribe()
    else
      IO.inspect("not connected")
    end

    {:ok, assign(socket, :blogs, list_blogs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info({:new_blog, blog}, socket) do
    {:noreply, assign(socket, :blogs, socket.assigns.blogs ++ [blog])}
  end

  def handle_info({:updated_blog, blog}, socket) do
    # updated_blog = Enum.filter(socket.assigns.blogs, fn b -> b.id == blog.id end)
    updated =
      Enum.map(
        socket.assigns.blogs,
        fn b ->
          if b.id == blog.id do
            blog
          else
            b
          end
        end
      )

    {:noreply, assign(socket, :blogs, updated)}
  end

  def handle_info({:delete_blog, blog}, socket) do
    updates_blogs = Enum.reject(socket.assigns.blogs, fn b -> b.id == blog.id end)
    {:noreply, assign(socket, :blogs, updates_blogs)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Blog")
    |> assign(:blog, Blogs.get_blog!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Blog")
    |> assign(:blog, %Blog{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Blogs")
    |> assign(:blog, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    blog = Blogs.get_blog!(id)
    {:ok, _} = Blogs.delete_blog(blog)

    {:noreply, assign(socket, :blogs, list_blogs())}
  end

  defp list_blogs do
    Blogs.list_blogs()
  end
end
