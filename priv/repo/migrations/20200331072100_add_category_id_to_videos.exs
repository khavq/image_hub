defmodule ImageHub.Repo.Migrations.AddCategoryIdToVideos do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :category_id, references(:categories, on_delete: :nilify_all)
    end
  end
end
