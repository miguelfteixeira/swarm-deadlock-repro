### Swarm deadlock repro

This repository serves as a repro for bitwalker/swarm#91 .
To start reproducing, simply run:

```sh
docker-compose up --scale repro=5
```

This command will build a docker image with the compiled repro Elixir application,
and run 5 instances of the image. All the application does is start `Swarm` and
 `Libcluster` with `Cluster.Strategy.Gossip` topology. A single process on each
node prints state of the local `Swarm.Tracker` process.
