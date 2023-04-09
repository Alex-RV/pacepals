use super::*;
use std::collections::HashMap;

#[derive(Serialize, Clone, Default, Debug)]
pub struct UserConnections(pub HashMap<UserId, UserFriends>);

#[derive(Serialize, Clone, Default, Debug)]
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
pub struct AOFriendAdd {
    pub ok: bool,
    pub error: &'static str,
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

pub fn api_fr_add(state: &mut AppState, req: AIFriendAdd) -> Result<AOFriendAdd, &'static str> {
    let uid = get_with_session(state, req.sid)?;
    let user_connection = state
        .user_connections
        .0
        .get(&uid)
        .ok_or("Requesting user does not exist")?;
    let other_connection = state
        .user_connections
        .0
        .get(&req.add)
        .ok_or("Add user does not exist")?;
    if user_connection.pending_sent.contains(&req.add) {
        Err("This user is a pending friend")?;
    }
    if user_connection.friends.contains(&req.add) {
        Err("This user is already a friend")?;
    }

    if other_connection.pending_sent.contains(&uid) {
        let other_connection = state.user_connections.0.get_mut(&req.add).unwrap();
        let idx = other_connection
            .pending_sent
            .iter()
            .position(|f| f == &uid)
            .unwrap();
        other_connection.pending_sent.remove(idx);
        other_connection.friends.push(uid.clone());
        let user_connection = state.user_connections.0.get_mut(&uid).unwrap();
        user_connection.friends.push(req.add);
        Ok(AOFriendAdd {
            ok: true,
            error: "",
        })
    } else {
        let user_connection = state.user_connections.0.get_mut(&uid).unwrap();
        user_connection.pending_sent.push(req.add.clone());
        Ok(AOFriendAdd {
            ok: true,
            error: "",
        })
    }
}

#[test]
fn test_friends() {
    let richard = "a";
    let richard_p = "classwritesrunstate";
    let richy = "b";
    let richy_p = "extensdsdatsrsruns";

    let mut state = AppState::default();

    let res_a = api_login_signup(
        &mut state,
        AILoginSignup {
            email: String::from(richard),
            password: String::from(richard_p),
        },
    )
    .unwrap();

    let res_aa = api_login_auth(
        &mut state,
        AILoginAuth {
            email: String::from(richard),
            password: String::from(richard_p),
        },
    )
    .unwrap();

    let res_b = api_login_signup(
        &mut state,
        AILoginSignup {
            email: String::from(richy),
            password: String::from(richy_p),
        },
    )
    .unwrap();

    let res_ba = api_login_auth(
        &mut state,
        AILoginAuth {
            email: String::from(richy),
            password: String::from(richy_p),
        },
    )
    .unwrap();

    api_fr_add(
        &mut state,
        AIFriendAdd {
            sid: res_aa.sid,
            add: res_b.uid,
        },
    )
    .unwrap();

    api_fr_add(
        &mut state,
        AIFriendAdd {
            sid: res_ba.sid,
            add: res_a.uid,
        },
    )
    .unwrap();

    eprintln!("state {:?}", state);

    //  Manually Check.
    //  We are on a limited time budget.
    // panic!()
}
