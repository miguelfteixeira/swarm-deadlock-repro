## Swarm deadlock

The goal of this repository is to help debugging an issue in [Swarm](https://github.com/bitwalker/swarm) where one node
hangs in the `awaiting_sync_ack` state.

**Please note** not all executions will result in a deadlock.

### Steps to reproduce

```sh
docker-compose build repro_{2,1,3}
docker-compose up repro_{2,1,3}
```

### Expected result

You should see one node in the `awaiting_sync_ack` state and the other two nodes in the `tracking` state. This situation
can be identified by the following line in the docker output:
```
Swarm.Tracker state: awaiting_sync_ack
```

You should also see the following warning:

```
[tracker:handle_cast] unrecognized cast: {:sync_recv, #PID<16218.180.0>, {{0, {0, 1}}, 0}, []}
```
