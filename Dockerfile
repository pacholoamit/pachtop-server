FROM rust:1.69 as builder

RUN USER=root cargo new --bin pachtop-update-server
WORKDIR ./pachtop-update-server
COPY ./Cargo.toml ./Cargo.toml
RUN cargo build --release
RUN rm src/*.rs

ADD . ./

RUN rm ./target/release/deps/*
RUN cargo build --release


FROM debian:buster-slim
ARG APP=/usr/src/app

RUN apt-get update \
    && apt-get install -y ca-certificates tzdata \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8000

ENV ROCKET_ADDRESS=0.0.0.0
ENV ROCKET_ENV=release
ENV APP_USER=appuser

RUN groupadd $APP_USER \
    && useradd -g $APP_USER $APP_USER \
    && mkdir -p ${APP}

COPY --from=builder /pachtop-update-server/target/release/pachtop-update-server ${APP}/pachtop-update-server

RUN chown -R $APP_USER:$APP_USER ${APP}

USER $APP_USER
WORKDIR ${APP}

CMD ["./pachtop-update-server"]