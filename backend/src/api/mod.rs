mod auth;
mod config;
mod friends;
mod schedule;

use google_maps::prelude::*;
use serde::{Deserialize, Serialize};

pub use auth::*;
pub use config::*;
pub use friends::*;
pub use schedule::*;

type StaticAsset = String;
type UserId = String;
type SessionId = String;
type InviteId = String;
type EventId = String;
type Directions = String;

#[derive(Serialize, Clone, Debug)]
pub struct AppState {
    user_auths: UsersAuths,
    user_sessions: UserSessions,
    user_configs: UserConfigs,
    user_connections: UserConnections,

    #[serde(skip_serializing)]
    google_maps: GoogleMapsClient,
}

const GOOGLE_MAPS_API_KEY: &str = "AIzaSyCjUSgaObg-TZMjFNWpxNRAxe-djtY9FKM";

impl AppState {
    pub fn new() -> Self {
        let google_maps = GoogleMapsClient::new(GOOGLE_MAPS_API_KEY);

        AppState {
            user_auths: UsersAuths::default(),
            user_sessions: UserSessions::default(),
            user_configs: UserConfigs::default(),
            user_connections: UserConnections::default(),
            google_maps,
        }
    }
}
