defmodule ImageHub.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar_url, :string
    field :email, :string
    field :name, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :phone_number, :name, :avatar_url])
    |> validate_required([:email, :phone_number, :name, :avatar_url])
  end
end
