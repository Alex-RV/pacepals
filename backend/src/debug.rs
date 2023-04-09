use super::*;

pub async fn net_api_dbg_get(State(state): State<ServerAppState>) -> Json<AppState> {
    let state = state.read().unwrap();
    Json(state.clone())
}
