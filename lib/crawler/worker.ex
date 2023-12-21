defmodule Crawler.Worker do
  @moduledoc false

  use GenServer

  def start_link(callback_fun) do
    GenServer.start_link(__MODULE__, callback_fun)
  end

  def init(state), do: {:ok, state}

  def dispatch(pid, url) do
    GenServer.call(pid, {:request, url})
  end

  def handle_call({:request, url}, _from, state) do
    {:ok, {_, _, body}} = :httpc.request(:get, {url, []}, [], [])
    body |> :erlang.list_to_binary() |> state.()
    {:reply, :ok, state}
  end
end
