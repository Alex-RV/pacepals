mod auth;
mod config;
mod friends;

use serde::{Deserialize, Serialize};

pub use auth::*;
pub use config::*;
pub use friends::*;

type StaticAsset = String;
type UserId = String;
type SessionId = String;
type InviteId = String;
type EventId = String;

#[derive(Serialize, Clone, Default, Debug)]
pub struct AppState {
    user_auths: UsersAuths,
    user_sessions: UserSessions,
    user_configs: UserConfigs,
    user_connections: UserConnections,
}
