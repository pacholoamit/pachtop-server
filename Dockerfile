FROM rust:1.69 as builder
WORKDIR /app
COPY . .
RUN cargo install --path .

FROM debian:buster-slim as runner
COPY --from=builder /usr/local/cargo/bin/pachtop-update-server /usr/local/bin/pachtop-update-server 
ENV ROCKET_ADDRESS=0.0.0.0
ENV ROCKET_ENV=release
EXPOSE 8000
CMD ["pachtop-update-server"]