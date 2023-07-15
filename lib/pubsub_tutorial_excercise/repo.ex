defmodule PubsubTutorialExcercise.Repo do
  use Ecto.Repo,
    otp_app: :pubsub_tutorial_excercise,
    adapter: Ecto.Adapters.Postgres
end
