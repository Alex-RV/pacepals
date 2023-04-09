use axum::{
    extract::{Json, State},
    http::{Method, Request, Response},
    routing::{get, post},
    Router,
};
use std::sync::{Arc, RwLock};
use tower_http::cors::{Any, CorsLayer};

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
        .route("/api/cfg/get", post(net_api_cfg_get))
        .route("/api/cfg/set_public", post(net_api_cfg_set_public))
        .route("/api/cfg/set_private", post(net_api_cfg_set_private))
        .route("/api/fr/lookup", post(net_api_fr_lookup))
        .route("/api/fr/get", post(net_api_fr_get))
        .with_state(state);
    Ok(router.into())
}
