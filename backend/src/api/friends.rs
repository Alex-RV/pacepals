use super::*;
use std::collections::HashMap;

#[derive(Serialize, Clone, Default)]
pub struct UserConnections(HashMap<UserId, UserFriends>);

#[derive(Serialize, Clone)]
pub struct UserFriends {
    pending_sent: Vec<UserId>,
    friends: Vec<UserId>,
}

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct AOFriendLookUp {
    pub ok: bool,
    pub error: &'static str,
    pub is_pending: bool,
    pub config: UserPublicConfig,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct AIFriendLookUp {
    self_uid: UserId,
    lookup_uid: UserId,
}

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct AOFriendGet {
    pub ok: bool,
    pub error: &'static str,
    pub pending_adds: Vec<UserId>,
    pub friends: Vec<UserId>,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct AIFriendGet {
    sid: SessionId,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct AIFriendAdd {
    sid: SessionId,
    add: UserId,
}

pub fn api_fr_lookup(
    state: &mut AppState,
    req: AIFriendLookUp,
) -> Result<AOFriendLookUp, &'static str> {
    let self_connection = state
        .user_connections
        .0
        .get(&req.self_uid)
        .ok_or("User is not logged in")?;
    let lookup_config = state
        .user_configs
        .0
        .get(&req.lookup_uid)
        .ok_or("Impossible, config not defined")?
        .0
        .clone();

    let is_pending = self_connection
        .pending_sent
        .iter()
        .any(|uid| *uid == req.lookup_uid);

    Ok(AOFriendLookUp {
        is_pending,
        config: lookup_config,
        ok: true,
        ..Default::default()
    })
}

pub fn api_fr_get(state: &mut AppState, req: AIFriendGet) -> Result<AOFriendGet, &'static str> {
    let uid = get_with_session(state, req.sid)?;
    let pending_adds = state
        .user_connections
        .0
        .iter()
        .filter_map(|(connection_uid, connection)| {
            (uid != *connection_uid
                && connection
                    .pending_sent
                    .iter()
                    .any(|pending_uid| *pending_uid == uid))
            .then_some(connection_uid)
        })
        .cloned()
        .collect::<Vec<_>>();

    let friends = state.user_connections.0[&uid].friends.clone();

    Ok(AOFriendGet {
        pending_adds,
        friends,
        ok: true,
        ..Default::default()
    })
}

pub fn api_fr_add(state: &mut AppState, req: AIFriendGet) -> Result<AOFriendGet, &'static str> {
    todo!()
}
