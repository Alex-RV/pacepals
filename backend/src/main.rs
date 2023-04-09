use axum::{
    extract::{Json, State},
    http::StatusCode,
    routing::{get, post},
    Router,
};
use std::sync::{Arc, RwLock};

mod api;
mod debug;
mod net;

pub use api::*;
pub use debug::*;
pub use net::*;

async fn hello_world() -> &'static str {
    log::warn!("Hello World");
    "Hello, world!"
}

type ServerAppState = Arc<RwLock<AppState>>;

#[shuttle_runtime::main]
async fn axum() -> shuttle_axum::ShuttleAxum {
    let state = Arc::new(RwLock::new(AppState::default()));

    let router = Router::new()
        .route("/hello", get(hello_world))
        .route("/api/dbg/get", get(net_api_dbg_get))
        .route("/api/login/signup", post(net_api_login_signup))
        .route("/api/login/auth", post(net_api_login_auth))
        .with_state(state);
    Ok(router.into())
}
