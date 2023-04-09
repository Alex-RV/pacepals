use super::*;

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

pub async fn net_api_cfg_get(
    State(state): State<ServerAppState>,
    Json(req): Json<AIConfigGet>,
) -> Result<Json<AOConfigGet>, StatusCode> {
    let state = state.read().unwrap();
    api_cfg_get(&state, req)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)
        .map(Json)
}

pub async fn net_api_cfg_set_public(
    State(state): State<ServerAppState>,
    Json(req): Json<AIConfigSetPublic>,
) -> Result<Json<()>, StatusCode> {
    let mut state = state.write().unwrap();
    api_cfg_set_public(&mut state, req)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)
        .map(Json)
}

pub async fn net_api_cfg_set_private(
    State(state): State<ServerAppState>,
    Json(req): Json<AIConfigSetPrivate>,
) -> Result<Json<()>, StatusCode> {
    let mut state = state.write().unwrap();
    api_cfg_set_private(&mut state, req)
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR)
        .map(Json)
}
