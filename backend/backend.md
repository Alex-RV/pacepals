# Backend for Pacepals

## Extra Investigations Needed

https://docs.rs/google_maps/latest/google_maps/
https://pub.dev/documentation/google_maps_flutter/latest/

## Global Definitions

```

type StaticAsset = String;
type UserId = String;
type SessionId = String;
type InviteId = String;
type EventId = String;
//  https://developers.google.com/maps/documentation/javascript/reference/directions#DirectionsResult
type Location = String;
//  https://developers.google.com/maps/documentation/javascript/reference/places-service#PlaceResult
type Directions = String;

```

## Global State 

```

BackendState:
    auth: HashMap<SessionId, UserId>,
    users: HashMap<UserId, {
        UserAuth, 
        ::UserConnections, 
        UserPublicConfig, 
        UserPrivateConfig, 
    }>,
    pools: Pools,
    events: Events,

UserAuth:
    hash: String,

UserPublicConfig:
    name: String,
    profile: String,
    profile_picture: StaticAsset,

UserPrivateConfig:
    weekly_miles: u32,

UserConnections:
    added: Vec<UserId>,
    friends: Vec<UserId>,

UserInvite:
    time: Time,
    location: Location,
    directions: Directions,

PoolMailbox:
    users: HashMap<UserId, {
        invitations: Vec<InviteId>,
        accepts: Vec<InviteId>,
        cancels: Vec<InviteId>,
    }>,

Pools:
    pools: HashMap<InviteId, {
        is_public: bool,
        invited: Vec<UserId>,
        joined: Vec<UserId>,
        invite: UserInvite,
    }>
    pool_mailbox: PoolMailbox,

Event:
    name: String
    invite: InviteId,

Events:
    events: HashMap<EventId, Event>,

```

## Login API (Optional)

```

/api/login/signup

in:
    username: String,
    password: String,

out:
    uid: UserId,

/api/login/auth

in:
    username: String,
    password: String,

out:
    sid: SessionId,

```

## User Config API

```

/api/cfg/get

in:
    sid: SessionId,

out:
    public_config: UserPublicConfig,
    private_config: UserPrivateConfig,

/api/cfg/set_public

in:
    sid: SessionId,
    config: UserPublicConfig,

/api/cfg/set_private

in:
    sid: SessionId,
    config: UserPrivate,

```

## Scheduling API

```

/api/sch/suggest

in:
    sid: SessionId,
    nearby: Vec<(Directions, Location)>,

out:
    suggestions: Vec<{
        day_name: String,
        location: Location,
        directions: Directions
        walk_duration: u32,
        walk_distance: u32,
    }>,

```

## Friend API

```

/api/fr/lookup

in: 
    uid: UserId,

out:
    is_pending: bool,
    config: UserPublicConfig,

/api/fr/get

in:
    sid: SessionId,

out:
    pending: Vec<UserId>,
    friends: Vec<UserId>,

```

## Invites

```
/api/invite/get

in:
    sid: SessionId,
    invite: InviteId

out:
    invite: UserInvite

/api/invite/notify_get

in:
    sid: SessionId,

out: 
    cancels: Vec<InviteId>,
    accepts: Vec<InviteId>,
    invitations: Vec<InviteId>,

/api/invite/invite

in:
    sid: SessionId,
    invite: UserInvite,

out:
    invite: InviteId,

/api/invite/accept

in:
    sid: SessionId,
    invite: InviteId,

/api/invite/cancel

in:
    sid: SessionId,
    invite: InviteId,

```

## Events API (Optional)

```

/api/ev/list

out:
    events: Vec<EventId>,

/api/ev/get

in:
    sid: SessionId,
    invite: EventId,

out:
    invite: UserInvite,
    event: Event,


/api/ev/notify_get

in:
    sid: SessionId,

out: 
    cancels: Vec<InviteId>,

/api/ev/create

in:
    sid: SessionId,
    event: Event,

out:
    event: EventId,

/api/ev/cancel

in:
    sid: SessionId,
    event: EventId,

```

## Progress

### Core

[ ] /api/cfg/get
[ ] /api/cfg/set_public
[ ] /api/cfg/set_private

[ ] /api/fr/lookup
[ ] /api/fr/get

[ ] /api/invite/get
[ ] /api/invite/notify_get
[ ] /api/invite/invite
[ ] /api/invite/accept
[ ] /api/invite/cancel

[ ] /api/sch/suggest

### Extra

[ ] /api/login/signup
[ ] /api/login/auth

[ ] /api/ev/list
[ ] /api/ev/get
[ ] /api/ev/notify_get
[ ] /api/ev/create
[ ] /api/ev/cancel
