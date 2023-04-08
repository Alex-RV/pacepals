use super::*;
use axum::{
    extract::{Json, State},
    http::StatusCode,
    response::IntoResponse,
};

pub async fn net_api_login_signup(
    State(state): State<ServerAppState>,
    Json(req): Json<AILoginSignup>,
) -> Result<Json<AOLoginSignup>, StatusCode> {
    let mut state = state.write().unwrap();
    api_login_signup(&mut state, req)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)
        .map(Json)
}

pub async fn net_api_login_auth(
    State(state): State<ServerAppState>,
    Json(req): Json<AILoginAuth>,
) -> Result<Json<AOLoginAuth>, StatusCode> {
    let mut state = state.write().unwrap();
    api_login_auth(&mut state, req)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)
        .map(Json)
}
