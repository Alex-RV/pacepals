use super::*;
use sha256::digest;
use std::collections::HashMap;
use uuid::Uuid;
use serde::{Serialize, Deserialize};

#[derive(Default)]
pub struct UserSessions(HashMap<SessionId, UserId>);

#[derive(Default)]
pub struct UsersAuths(HashMap<UserId, UserAuthStore>);

#[derive(Serialize, Deserialize)]
struct UserAuthStore {
    username: String,
    hash: String,
}

#[derive(Serialize, Deserialize)]
pub struct AOLoginSignup {
    uid: UserId,
}

#[derive(Serialize, Deserialize)]
pub struct AILoginSignup {
    username: String,
    password: String,
}

#[derive(Serialize, Deserialize)]
pub struct AOLoginAuth {
    uid: UserId,
    sid: SessionId,
}

#[derive(Serialize, Deserialize)]
pub struct AILoginAuth {
    username: String,
    password: String,
}

fn create_user_hash(username: &str, password: &str) -> String {
    digest(String::from(username) + password)
}

pub fn api_login_signup(
    AppState { user_auths, .. }: &mut AppState,
    req: AILoginSignup,
) -> Option<AOLoginSignup> {
    if !user_auths
        .0
        .values()
        .any(|auth_store| auth_store.username == req.username)
    {
        let uid = Uuid::new_v4().to_string();
        user_auths.0.insert(
            uid.clone(),
            UserAuthStore {
                hash: create_user_hash(&req.username, &req.password),
                username: req.username,
            },
        );
        Some(AOLoginSignup { uid })
    } else {
        None?
    }
}

pub fn api_login_auth(
    AppState {
        user_auths,
        user_sessions,
        ..
    }: &mut AppState,
    req: AILoginAuth,
) -> Option<AOLoginAuth> {
    if let Some((uid, _)) = user_auths
        .0
        .iter()
        .find(|(_, auth_store)| auth_store.hash == create_user_hash(&req.username, &req.username))
    {
        let sid = Uuid::new_v4().to_string();
        user_sessions.0.insert(sid.clone(), uid.clone());
        Some(AOLoginAuth {
            uid: uid.clone(),
            sid,
        })
    } else {
        None
    }
}
