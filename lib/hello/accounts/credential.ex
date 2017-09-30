defmodule Hello.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Accounts.Credential


  schema "credentials" do
    field :email, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Credential{} = credential, attrs) do
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
