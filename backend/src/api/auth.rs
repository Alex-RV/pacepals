use super::*;
use serde::{Deserialize, Serialize};
use sha256::digest;
use std::collections::HashMap;
use uuid::Uuid;

#[derive(Serialize, Clone, Default, Debug)]
pub struct UserSessions(HashMap<SessionId, UserId>);

#[derive(Serialize, Clone, Default, Debug)]
pub struct UsersAuths(HashMap<UserId, UserAuthStore>);

#[derive(Serialize, Clone, Deserialize, Debug)]
struct UserAuthStore {
    email: String,
    hash: String,
}

#[derive(Serialize, Deserialize, Default)]
pub struct AOLoginSignup {
    pub ok: bool,
    pub error: &'static str,
    pub uid: UserId,
}

#[derive(Serialize, Deserialize)]
pub struct AILoginSignup {
    pub email: String,
    pub password: String,
}

#[derive(Serialize, Deserialize, Default)]
pub struct AOLoginAuth {
    pub ok: bool,
    pub error: &'static str,
    pub uid: UserId,
    pub sid: SessionId,
}

#[derive(Serialize, Deserialize)]
pub struct AILoginAuth {
    pub email: String,
    pub password: String,
}

pub fn get_with_session(
    AppState { user_sessions, .. }: &AppState,
    sid: SessionId,
) -> Result<UserId, &'static str> {
    user_sessions
        .0
        .get(&sid)
        .cloned()
        .ok_or("User is not logged in")
}

fn create_user_hash(email: &str, password: &str) -> String {
    digest(String::from(email) + password)
}

pub fn api_login_signup(
    state: &mut AppState,
    req: AILoginSignup,
) -> Result<AOLoginSignup, &'static str> {
    log::warn!("api_login_signup");
    if !state
        .user_auths
        .0
        .values()
        .any(|auth_store| auth_store.email == req.email)
    {
        let uid = Uuid::new_v4().to_string();
        state.user_auths.0.insert(
            uid.clone(),
            UserAuthStore {
                hash: create_user_hash(&req.email, &req.password),
                email: req.email,
            },
        );
        state.user_configs.0.insert(
            uid.clone(),
            (UserPublicConfig::default(), UserPrivateConfig::default()),
        );
        state
            .user_connections
            .0
            .insert(uid.clone(), UserFriends::default());

        Ok(AOLoginSignup {
            uid,
            ok: true,
            ..Default::default()
        })
    } else {
        Err("There is already an account under this email.")
    }
}

pub fn api_login_auth(
    AppState {
        user_auths,
        user_sessions,
        ..
    }: &mut AppState,
    req: AILoginAuth,
) -> Result<AOLoginAuth, &'static str> {
    log::warn!("api_login_auth");
    if let Some((uid, _)) = user_auths
        .0
        .iter()
        .find(|(_, auth_store)| auth_store.hash == create_user_hash(&req.email, &req.password))
    {
        let sid = Uuid::new_v4().to_string();
        user_sessions.0.insert(sid.clone(), uid.clone());
        Ok(AOLoginAuth {
            uid: uid.clone(),
            sid,
            ok: true,
            ..Default::default()
        })
    } else {
        Err("This user does not exist")
    }
}
