use reqwest::Client;
mod releases;
mod utils;
use releases::{new_tauri_gh_release, PachtopRelease};

#[macro_use]
extern crate rocket;

#[launch]
fn rocket() -> _ {
    let pachtop_release: PachtopRelease = new_tauri_gh_release();
    let reqwest_client = Client::builder()
        .user_agent("reqwest")
        .build()
        .expect("reqwest client could not be built");
    rocket::build()
        .manage(reqwest_client)
        .manage(pachtop_release)
        .attach(rocket_csrf::Fairing::default())
        .mount(releases::BASE, releases::routes())
}
