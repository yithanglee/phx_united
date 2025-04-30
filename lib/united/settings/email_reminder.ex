defmodule United.Settings.EmailReminder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "email_reminders" do
    field :content, :binary
    field :status, :string, default: "pending"
    field :is_sent, :boolean, default: false

    # belongs_to :loan, United.Settings.Loan
    # field :member_id, :integer
    belongs_to :member, United.Settings.Member

    belongs_to :organization, United.Settings.Organization

    timestamps()
  end

  @doc false
  def changeset(email_reminder, attrs) do
    email_reminder
    |> cast(attrs, [:member_id, :content, :is_sent, :status, :organization_id])
    |> validate_required([:member_id])
  end
end
