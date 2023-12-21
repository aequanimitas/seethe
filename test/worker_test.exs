defmodule Crawler.WorkerTest do
  use ExUnit.Case

  alias Crawler.Worker

  test "greets the world" do
    fun = fn x ->
      Floki.find(x, "a")
      |> IO.inspect
    end

    {:ok, pid} = Worker.start_link(fun)
    url = ~c"https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm"
    Worker.dispatch(pid, url)
  end
end
