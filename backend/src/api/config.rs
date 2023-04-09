use super::*;
use std::collections::HashMap;

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct UserPublicConfig {
    name: String,
    profile: String,
    profile_picture: StaticAsset,
}

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct UserPrivateConfig {
    weekly_miles: u32,
}

#[derive(Serialize, Clone, Default)]
pub struct UserConfigs(pub HashMap<UserId, (UserPublicConfig, UserPrivateConfig)>);

#[derive(Serialize, Deserialize, Default)]
pub struct AOConfigGet {
    pub ok: bool,
    pub error: &'static str,
    pub public_config: UserPublicConfig,
    pub private_config: UserPrivateConfig,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct AIConfigGet {
    sid: SessionId,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct AIConfigSetPublic {
    sid: SessionId,
    config: UserPublicConfig,
}

#[derive(Serialize, Deserialize, Clone, Default)]
pub struct AOConfigSetPublic {
    pub ok: bool,
    pub error: &'static str,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct AIConfigSetPrivate {
    sid: SessionId,
    config: UserPrivateConfig,
}

#[derive(Serialize, Deserialize, Clone, Default)]
pub struct AOConfigSetPrivate {
    pub ok: bool,
    pub error: &'static str,
}

pub fn api_cfg_get(state: &AppState, req: AIConfigGet) -> Result<AOConfigGet, &'static str> {
    let uid = get_with_session(state, req.sid)?;
    let configs = state.user_configs.0[&uid].clone();
    Ok(AOConfigGet {
        public_config: configs.0,
        private_config: configs.1,
        ..Default::default()
    })
}

pub fn api_cfg_set_public(
    state: &mut AppState,
    req: AIConfigSetPublic,
) -> Result<AOConfigSetPublic, &'static str> {
    eprintln!("api_cfg_set_public");
    let uid = get_with_session(state, req.sid)?;
    state.user_configs.0.get_mut(&uid).unwrap().0 = req.config;
    Ok(AOConfigSetPublic {
        ok: true,
        error: "",
    })
}

pub fn api_cfg_set_private(
    state: &mut AppState,
    req: AIConfigSetPrivate,
) -> Result<AOConfigSetPrivate, &'static str> {
    let uid = get_with_session(state, req.sid)?;
    state.user_configs.0.get_mut(&uid).unwrap().1 = req.config;
    Ok(AOConfigSetPrivate {
        ok: true,
        error: "",
    })
}
