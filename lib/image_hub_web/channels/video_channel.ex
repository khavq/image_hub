defmodule ImageHubWeb.VideoChannel do
  use ImageHubWeb, :channel

  def join("videos:" <> video_id, _params, socket) do
    IO.inspect(video_id, lable: "video_id")
    #{:ok, assign(socket, :video_id, String.to_integer(video_id))}
    :timer.send_interval(5_000, :ping)
    {:ok, socket}
  end

  def handle_in("new_annotation", params, socket) do
    user = current_user(socket.assigns[:current_user])
    broadcast!(socket, "new_annotation", %{
      user: %{username: user.email},
      body: params["body"],
      at: params["at"]
    })

    {:reply, :ok, socket}
  end

  def handle_info(:ping, socket) do
    count = socket.assigns[:count] || 1
    push(socket, "ping", %{count: count})

    {:noreply, assign(socket, :count, count + 1)}
  end

  defp current_user(id) do
    ImageHub.Accounts.get_user!(id)
  end
end
