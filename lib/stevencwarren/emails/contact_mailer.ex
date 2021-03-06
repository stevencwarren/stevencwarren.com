defmodule Stevencwarren.ContactMailer do
  @moduledoc """
    Mailer for the public contact form
  """

  import Bamboo.Email

  def contact_email(%{"email" => email, "message" => message}) do
    new_email()
    |> to("steven@stevencwarren.com")
    |> from("noreply@stevencwarren.com")
    |> subject("#{email} has contacted you")
    |> text_body(message)
  end
end
