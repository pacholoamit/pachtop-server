<p align="center">
  <a href="#">
    
  </a>
  <p align="center">
   <img width="230" height="230" src="https://github.com/pacholoamit/pachtop/blob/master/public/logo-white.png?raw=true" alt="Logo">
  </p>
  <h1 align="center"><b>Pachtop Update Server</b></h1>
  <p align="center">
  The only system monitor application you'll ever need.
    <br />
    <b>Download for </b>
    <a href="https://github.com/pacholoamit/pachtop/releases">
    macOS
    ·
    Windows
    ·
    Linux
    </a>
    <br />
</p>
<a href="https://github.com/pacholoamit/pachtop">Pachtop </a> is a cross-platform desktop application built with Rust that allows you to monitor your system resources in real time.
<br/>
<br/>

> This is the update server for Pachtop. This server is responsible for checking for updates and downloading the latest version of Pachtop.

## Usage:

For the best experience use `docker-compose` to set up the update server.

1. Create a `docker-compose.yml` file with the following contents:

```yml
version: "3.3"
services:
  pachtop-update-server:
    image: ghcr.io/pacholoamit/pachtop-update-server:latest
    container_name: pachtop-update-server
    restart: always
    ports:
      - 8000:8000
```

2. Run `docker-compose up -d` to start the update server.

3. If you visit `http://localhost:5000/releases/pachtop/darwin-x86_64/3.0.3`, you should receive a JSON response that allows Pachtop to be updated
