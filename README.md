# Rust MMO Sandbox

This repository contains a work-in-progress sandbox MMO.
It aims to deliver a Minecraft-like experience with modern rendering and a
scalable server architecture.

## Features

- **Hardware ray tracing** only. There is no rasterization fallback.
- **Rendering back ends**: Metal on macOS and Vulkan on Windows and Linux.
- **Randomized scheduling**: most events occur after random durations instead of
  deterministic per-tick random block updates.
- **Server meshing** through multiple roles:
  - **Main** – accepts players and assigns them to front-end nodes.
  - **Front-End** – manages client connections and talks to middle-ends.
  - **Middle-End** – simulates and exchanges chunks with neighbors.
  - **Back-End** – stores world data and assigns chunks to middle-ends.
  - **Worker** – handles AI and events outside assigned chunks.
- **Highly multicore optimized** server implementation.
- **Plugin** support on both client and server.

See [`docs/protocol/README.md`](docs/protocol/README.md) for the networking
protocol specification.
