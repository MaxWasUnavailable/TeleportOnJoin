# TeleportOnJoin

TeleportOnJoin is a mod that allows admins to set up a versatile teleportation system to teleport players when they join
the game.

## Features

- Set target coordinates for teleportation.
- Set teleport ID, which ensures only-once teleportation.
    - Note that ID must be incremented in order to set up a new teleport. When a player is teleported, the system logs
      that this has been done for a specific ID and will not teleport the player again for that ID.