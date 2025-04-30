defmodule United.Mailer do
  use Bamboo.Mailer, otp_app: :united

  def send_email_for_org(org, email) do
    adapter_config = get_smtp_config_for_org(org) |> IO.inspect()

    deliver_later(email, config: adapter_config)
  end

  defp get_smtp_config_for_org(organization) do
    # config :united, United.Mailer, adapter: Bamboo.LocalAdapter

    case organization.smtp_setting.adapter_type do
      "smtp" ->
        %{
          adapter: Bamboo.SMTPAdapter,
          server: organization.smtp_setting.server || "smtp.mailersend.net",
          hostname: organization.smtp_setting.hostname || "united_app",
          port: 587,
          username: organization.smtp_setting.username,
          password: organization.smtp_setting.crypted_password |> United.Encryption.decrypt(),
          tls: :always,
          allowed_tls_versions: [:"tlsv1.2"],
          tls_log_level: :error,
          tls_verify: :verify_none,
          ssl: false,
          retries: 1,
          no_mx_lookups: false,
          auth: :if_available
        }

      "sendgrid" ->
        %{
          adapter: Bamboo.SendGridAdapter,
          api_key: organization.smtp_setting.crypted_password |> United.Encryption.decrypt(),
          hackney_opts: %{
            recv_timeout: :timer.minutes(1)
          }
        }

      _ ->
        %{
          adapter: Bamboo.LocalAdapter
        }
    end

    # Replace this with however you look up your org-specific credentials
  end
end

defmodule United.Email do
  import Bamboo.Email
  import Bamboo.Phoenix

  use Bamboo.Phoenix, view: UnitedWeb.EmailView

  @doc """
  United.Email.custom_email("yithanglee@gmail.com", "test1", "lots of htmls") |> United.Mailer.deliver_now
  """
  def custom_email(user_email, subject, html, %United.Settings.Organization{} = organization) do
    # Build your default email then customize for welcome
    base_email(organization)
    |> to(user_email)
    |> subject("#{organization.name} - #{subject}")
    |> put_header("Reply-To", "no-reply@damienslab.com")
    |> render("custom_email.html", html: html)
  end

  def remind_email(user_email, member, books, %United.Settings.Organization{} = organization) do
    # Build your default email then customize for welcome
    base_email(organization)
    |> to(user_email)
    |> subject("#{organization.name} - Loan return reminder")
    |> put_header(
      "Reply-To",
      "no-reply@#{Application.get_env(:united, UnitedWeb.Endpoint)[:url] |> Enum.into(%{}) |> Map.get(:host)}"
    )
    |> render("loan_reminder.html", member: member, books: books, organization: organization)
  end

  def reservation_email(
        customer_email,
        book,
        visitor,
        %United.Settings.Organization{} = organization
      ) do
    # Build your default email then customize for welcome
    base_email()
    |> to(customer_email)
    |> subject("#{organization.name} - Book reserved")
    |> put_header(
      "Reply-To",
      "no-reply@#{Application.get_env(:united, UnitedWeb.Endpoint)[:url] |> Enum.into(%{}) |> Map.get(:host)}"
    )
    |> render("reserve.html", book: book, member: visitor)
  end

  defp base_email(organization \\ nil) do
    default_host =
      if organization == nil do
        Application.get_env(:united, UnitedWeb.Endpoint)[:url] |> Enum.into(%{}) |> Map.get(:host)
      else
        organization.host_name
      end

    new_email()
    # Set a default from
    |> from("no-reply@#{default_host}")
    # Set default layout
    |> put_html_layout({UnitedWeb.LayoutView, "email.html"})

    # Set default text layout
    # |> put_text_layout({UnitedWeb.LayoutView, "email.text"})
  end
end

# United.Email.welcome_email |> United.Mailer.deliver_now
