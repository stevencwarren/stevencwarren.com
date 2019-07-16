defmodule StevencwarrenWeb.ContactController do
  use StevencwarrenWeb, :controller
  alias Stevencwarren.{ ContactMailer, Mailer }

  def index(conn, _) do
    render(conn, "index.html")
  end

  def create(conn, %{"contact" => %{ "honeypot" => honeypot }}) do
    conn
    |> put_flash(:error, "You are either a robot or are filling in a forbidden field. If you are human, please try again")
    |> redirect(to: "/contact")
  end

  def create(conn, %{"contact" => params }) do
    ContactMailer.contact_email(params)
    |> Mailer.deliver_now()

    conn
    |> put_flash(:info, "Thanks for contacting me, I'll reply as soon as I can!")
    |> redirect(to: "/contact")
  end

  def create(conn, _) do
    conn
    |> put_flash(:error, "Please enter an email and a message.")
    |> redirect(to: "/contact")
  end
end
