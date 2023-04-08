use axum::{
    routing::{get, post},
    Router,
};
use std::sync::{Arc, RwLock};

mod api;
mod net;

pub use api::*;
pub use net::*;

async fn hello_world() -> &'static str {
    "Hello, world!"
}

type ServerAppState = Arc<RwLock<AppState>>;

#[shuttle_runtime::main]
async fn axum() -> shuttle_axum::ShuttleAxum {
    let state = Arc::new(RwLock::new(AppState::default()));

    let router = Router::new()
        .route("/hello", get(hello_world))
        .route("/api/login/signup", post(net_api_login_signup))
        .route("/api/login/auth", post(net_api_login_auth))
        .with_state(state);
    Ok(router.into())
}