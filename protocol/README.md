# Protocol

This document defines the communication protocol between server and server or client.

## Server Node Roles

The server architecture is divided into the following layers:

- Main Server – Handles player entry, authentication, and routing to frontends
- Front-End – Maintains client connections and forwards messages to appropriate middle-end nodes
- Middle-End – Simulates chunk physics, manages chunk ownership, and communicates with neighboring middle-ends
- Back-End – Stores world state, validates chunk integrity, and handles world generation
- Worker – Manages AI agents, processes inter-chunk events, and handles background simulation outside assigned chunks

## Message Format

Every message starts with a fixed-size header:

|Field|Type|Description|
|--|--|--|
|`type`|u8~u16 (can be vary)|Message type|
|`length`|u32|Length of `payload`|
|`payload`|bytes|Message body|

The `type` determines how the payload is interpreted.

### Sample Message

> 0x0000000010DEADBEEFCAFECAFECAFEC0FFEEC0FFEE

- Message Type: Handshake (u8, 0x0000)
- Payload Length: 16 (u32, 0x00000010)
- Payload: 0xDEADBEEFCAFECAFECAFEC0FFEEC0FFEE
