use super::*;
use std::collections::HashMap;

#[derive(Serialize, Deserialize, Clone)]
pub struct UserPublicConfig {
    name: String,
    profile: String,
    profile_picture: StaticAsset,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct UserPrivateConfig {
    weekly_miles: u32,
}

#[derive(Serialize, Clone, Default)]
pub struct UserConfigs(pub HashMap<UserId, (UserPublicConfig, UserPrivateConfig)>);

pub struct AOConfigGet {
    public_config: UserPublicConfig,
    private_config: UserPrivateConfig,
}

pub struct AIConfigGet {
    sid: SessionId,
}

pub struct AIConfigSetPublic {
    sid: SessionId,
    config: UserPublicConfig,
}

pub struct AIConfigSetPrivate {
    sid: SessionId,
    config: UserPrivateConfig,
}

pub fn api_cfg_get(state: &AppState, req: AIConfigGet) -> Option<AOConfigGet> {
    let uid = get_with_session(state, req.sid)?;
    let configs = state.user_configs.0[&uid].clone();
    Some(AOConfigGet {
        public_config: configs.0,
        private_config: configs.1,
    })
}

pub fn api_cfg_set_public(state: &mut AppState, req: AIConfigSetPublic) -> Option<()> {
    eprintln!("api_cfg_set_public");
    let uid = get_with_session(state, req.sid)?;
    state.user_configs.0.get_mut(&uid).unwrap().0 = req.config;
    Some(())
}

pub fn api_cfg_set_private(state: &mut AppState, req: AIConfigSetPrivate) -> Option<()> {
    let uid = get_with_session(state, req.sid)?;
    state.user_configs.0.get_mut(&uid).unwrap().1 = req.config;
    Some(())
}
