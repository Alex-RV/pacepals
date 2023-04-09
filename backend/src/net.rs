use super::*;

pub async fn net_api_login_signup(
    State(state): State<ServerAppState>,
    Json(req): Json<AILoginSignup>,
) -> Json<AOLoginSignup> {
    let mut state = state.write().unwrap();
    match api_login_signup(&mut state, req) {
        Ok(r) => Json(r),
        Err(err) => Json(AOLoginSignup {
            ok: false,
            error: err,
            ..Default::default()
        }),
    }
}

pub async fn net_api_login_auth(
    State(state): State<ServerAppState>,
    Json(req): Json<AILoginAuth>,
) -> Json<AOLoginAuth> {
    let mut state = state.write().unwrap();

    match api_login_auth(&mut state, req) {
        Ok(r) => Json(r),
        Err(err) => Json(AOLoginAuth {
            ok: false,
            error: err,
            ..Default::default()
        }),
    }
}

pub async fn net_api_cfg_get(
    State(state): State<ServerAppState>,
    Json(req): Json<AIConfigGet>,
) -> Json<AOConfigGet> {
    let state = state.read().unwrap();

    match api_cfg_get(&state, req) {
        Ok(r) => Json(r),
        Err(err) => Json(AOConfigGet {
            ok: false,
            error: err,
            ..Default::default()
        }),
    }
}

pub async fn net_api_cfg_set_public(
    State(state): State<ServerAppState>,
    Json(req): Json<AIConfigSetPublic>,
) -> Json<AOConfigSetPublic> {
    let mut state = state.write().unwrap();
    match api_cfg_set_public(&mut state, req) {
        Ok(r) => Json(r),
        Err(err) => Json(AOConfigSetPublic {
            ok: false,
            error: err,
            ..Default::default()
        }),
    }
}

pub async fn net_api_cfg_set_private(
    State(state): State<ServerAppState>,
    Json(req): Json<AIConfigSetPrivate>,
) -> Json<AOConfigSetPrivate> {
    let mut state = state.write().unwrap();
    match api_cfg_set_private(&mut state, req) {
        Ok(r) => Json(r),
        Err(err) => Json(AOConfigSetPrivate {
            ok: false,
            error: err,
            ..Default::default()
        }),
    }
}
