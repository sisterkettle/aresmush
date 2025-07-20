---
toc: Blocking Players
summary: Avoiding bothersome communication.
tutorial: true
---
# Blocking Players

If another player is bothering you, there are various ways to report them. See the [Dealing with Harassment and Abuse tutorial](/help/trouble_tutorial) for more information. It is also possible to silence them using the block command.

`block/add <player>=<block type>` - Blocks a player. You can specify a type (see below) or use "all" for all types.
`block/remove <player>=<block type>` - Unblocks a player. You can specify a type (see below) or use "all" for all types.
`blocks` - Shows what blocks are active.

## Block Types

There are different types of blocks available, so you can fine-tune which communications to block. In the core AresMUSH game engine, available types are shown below. Custom game systems may also define new block types, so consult your local game documentation for details.

- pm - Blocks PMs/pages. The blocked player will receive a "do not disturb" failure message if they try to contact you (as if you had used the pm/dnd command.)
- channel - Will not show you channel messages from that player. They will not know.