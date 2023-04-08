use super::*;
use std::collections::HashMap;

pub struct UserPublicConfig {
    name: String,
    profile: String,
    profile_picture: StaticAsset,
}

pub struct UserPrivateConfig {
    weekly_miles: u32,
}

#[derive(Default)]
pub struct UserConfigs(HashMap<UserId, (UserPublicConfig, UserPrivateConfig)>);

pub struct AOConfigGet {
    sid: SessionId,
}

pub struct AIConfigGet {
    public_config: UserPublicConfig,
    private_config: UserPrivateConfig,
}

fn api_cfg_get(UserConfigs(configs): &UserConfigs, req: AIConfigGet) -> AOConfigGet {
    todo!()
}

fn api_cfg_set_public() {}

fn api_cfg_set_private() {}
