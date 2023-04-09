use super::*;
use serde::{Deserialize, Serialize};
use sha256::digest;
use std::collections::HashMap;
use uuid::Uuid;

#[derive(Serialize, Clone, Default)]
pub struct UserSessions(HashMap<SessionId, UserId>);

#[derive(Serialize, Clone, Default)]
pub struct UsersAuths(HashMap<UserId, UserAuthStore>);

#[derive(Serialize, Clone, Deserialize)]
struct UserAuthStore {
    email: String,
    hash: String,
}

#[derive(Serialize, Deserialize)]
pub struct AOLoginSignup {
    uid: UserId,
}

#[derive(Serialize, Deserialize)]
pub struct AILoginSignup {
    email: String,
    password: String,
}

#[derive(Serialize, Deserialize)]
pub struct AOLoginAuth {
    uid: UserId,
    sid: SessionId,
}

#[derive(Serialize, Deserialize)]
pub struct AILoginAuth {
    email: String,
    password: String,
}

pub fn get_with_session(
    AppState { user_sessions, .. }: &AppState,
    sid: SessionId,
) -> Option<UserId> {
    user_sessions.0.get(&sid).cloned()
}

fn create_user_hash(email: &str, password: &str) -> String {
    digest(String::from(email) + password)
}

pub fn api_login_signup(
    AppState { user_auths, .. }: &mut AppState,
    req: AILoginSignup,
) -> Option<AOLoginSignup> {
    if !user_auths
        .0
        .values()
        .any(|auth_store| auth_store.email == req.email)
    {
        let uid = Uuid::new_v4().to_string();
        user_auths.0.insert(
            uid.clone(),
            UserAuthStore {
                hash: create_user_hash(&req.email, &req.password),
                email: req.email,
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
        .find(|(_, auth_store)| auth_store.hash == create_user_hash(&req.email, &req.email))
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
