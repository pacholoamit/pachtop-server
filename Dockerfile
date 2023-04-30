# Use the official Rust image as the parent image
FROM rust:1.69 AS build

# Set the working directory to /app
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files to the container
COPY Cargo.toml Cargo.lock ./

# Build and cache dependencies separately from the application code
RUN cargo build --release

# Copy the application code to the container
COPY src ./src

# Build the application
RUN cargo build --release

# Use the official Debian Slim image as the base image for the final image
FROM debian:bullseye-slim

# Set the working directory to /app
WORKDIR /app

# Copy the application binary from the build stage to the final image
COPY --from=build /app/target/release/pachtop-update-server .

ENV ROCKET_ADDRESS=0.0.0.0
ENV ROCKET_ENV=release

# Expose the port on which the application will listen
EXPOSE 8000

# Start the application when the container starts
CMD ["./pachtop-update-server"]
