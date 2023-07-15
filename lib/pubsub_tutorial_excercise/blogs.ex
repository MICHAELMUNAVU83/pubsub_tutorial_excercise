defmodule PubsubTutorialExcercise.Blogs do
  @moduledoc """
  The Blogs context.
  """

  import Ecto.Query, warn: false
  alias PubsubTutorialExcercise.Repo

  alias PubsubTutorialExcercise.Blogs.Blog

  @doc """
  Returns the list of blogs.

  ## Examples

      iex> list_blogs()
      [%Blog{}, ...]

  """
  def list_blogs do
    Repo.all(Blog)
  end

  @doc """
  Gets a single blog.

  Raises `Ecto.NoResultsError` if the Blog does not exist.

  ## Examples

      iex> get_blog!(123)
      %Blog{}

      iex> get_blog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog!(id), do: Repo.get!(Blog, id)

  def subsribe, do: Phoenix.PubSub.subscribe(PubsubTutorialExcercise.PubSub, "blogs")

  def broadcast({:ok, blog}, event) do
    Phoenix.PubSub.broadcast(PubsubTutorialExcercise.PubSub, "blogs", {event, blog})
    {:ok, blog}
  end

  def broadcast({:error, changeset}, event) do
    {:error, changeset}
  end

  @doc """
  Creates a blog.

  ## Examples

      iex> create_blog(%{field: value})
      {:ok, %Blog{}}

      iex> create_blog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog(attrs \\ %{}) do
    %Blog{}
    |> Blog.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:new_blog)

    # Phoenix.PubSub.broadcast(PubsubTutorialExcercise.PubSub, "blogs", {:new_blog, blog})

    # {:ok, blog}
  end

  @doc """
  Updates a blog.

  ## Examples

      iex> update_blog(blog, %{field: new_value})
      {:ok, %Blog{}}

      iex> update_blog(blog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog(%Blog{} = blog, attrs) do
    blog
    |> Blog.changeset(attrs)
    |> Repo.update()
    |> broadcast(:updated_blog)
    
  end

  @doc """
  Deletes a blog.

  ## Examples

      iex> delete_blog(blog)
      {:ok, %Blog{}}

      iex> delete_blog(blog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog(%Blog{} = blog) do
    Repo.delete(blog)
    |> broadcast(:delete_blog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog changes.

  ## Examples

      iex> change_blog(blog)
      %Ecto.Changeset{data: %Blog{}}

  """
  def change_blog(%Blog{} = blog, attrs \\ %{}) do
    Blog.changeset(blog, attrs)
  end
end
