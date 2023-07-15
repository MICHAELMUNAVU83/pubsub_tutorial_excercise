defmodule PubsubTutorialExcercise.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :name, :string

      timestamps()
    end
  end
end
