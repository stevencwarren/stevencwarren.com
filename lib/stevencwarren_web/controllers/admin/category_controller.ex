defmodule StevencwarrenWeb.Admin.CategoryController do
  use StevencwarrenWeb, :controller

  alias Stevencwarren.Repo
  alias Stevencwarren.ReadingList
  alias Stevencwarren.ReadingList.Category

  def index(conn, _params) do
    render(conn, "index.html", categories: ReadingList.list_categories)
  end

  def new(conn, _params) do
    changeset = Category.changeset(%Category{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    case ReadingList.create_category(category_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Category created successfully")
        |> redirect(to: Routes.admin_category_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was an error with your submission")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)
    changeset = ReadingList.category_changeset(category)

    render(conn, "edit.html", changeset: changeset, category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Repo.get!(Category, id)

    case ReadingList.update_category(category, category_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: Routes.admin_category_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)

    Repo.delete(category)

    conn
    |> put_flash(:info, "Category deleted.")
    |> redirect(to: Routes.admin_category_path(conn, :index))
  end
end
