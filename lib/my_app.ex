defmodule TrackerStateMonitor do
  use Task, restart: :permanent

  def start_link(_args) do
    Task.start_link(fn ->
      Stream.repeatedly(fn -> Process.sleep(5000) end)
      |> Enum.each(fn _ ->
        {state, _} = :sys.get_state(Swarm.Tracker)
        IO.puts("Swarm.Tracker state: #{state}")
      end)
    end)
  end
end

defmodule MyApp do
  use Application

  @impl Application
  def start(_type, _args) do
    {sleep_time, _} = Integer.parse(System.get_env("BOOT_SLEEP_TIME"))
    IO.puts "sleeping for #{sleep_time}"
    :timer.sleep(sleep_time)

    Supervisor.start_link([
      {Cluster.Supervisor,
       [[local: [strategy: Cluster.Strategy.Gossip]], [name: MyApp.ClusterSupervisor]]},
      {TrackerStateMonitor, []}
    ], strategy: :one_for_one)
  end
end
