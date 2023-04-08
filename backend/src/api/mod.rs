mod auth;
mod config;

pub use auth::*;
pub use config::*;

type StaticAsset = String;
type UserId = String;
type SessionId = String;
type InviteId = String;
type EventId = String;

#[derive(Default)]
pub struct AppState {
    user_auths: UsersAuths,
    user_sessions: UserSessions,
    user_configs: UserConfigs,
}
