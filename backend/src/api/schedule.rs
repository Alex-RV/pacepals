use super::*;

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct Location {
    latitude: f64,
    longitude: f64,
}

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct NearbyItem {
    location: Location,
    directions: Directions,
}

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct SuggestionItem {
    day_name: String,
    location: Location,
    directions: Directions,
    walk_duration: u32,
    walk_distance: u32,
}

#[derive(Serialize, Deserialize, Default, Clone)]
pub struct AOScheduleSuggest {
    pub ok: bool,
    pub error: &'static str,
    pub nearby: Vec<google_maps::places::place_search::text_search::response::Response>,
}

#[derive(Serialize, Deserialize, Clone)]
pub struct AIScheduleSuggest {
    location: Location,
}

pub async fn api_sch_suggest(req: AIScheduleSuggest) -> Result<AOScheduleSuggest, &'static str> {
    let mut all_nearbys = vec![];
    for ty in [
        "amusement_park",
        "aquarium",
        "art_gallery",
        "bakery",
        "book_store",
        "cafe",
        "campground",
        "cemetery",
        "church",
        "clothing_store",
        "drugstore",
        "florist",
        "gym",
        "hair_care",
        "hindu_temple",
        "hospital",
        "insurance_agency",
        "laundry",
        "library",
        "lodging",
        "meal_delivery",
        "meal_takeaway",
        "mosque",
        "museum",
        "park",
        "parking",
        "restaurant",
        "rv_park",
        "spa",
        "stadium",
        "synagogue",
        "zoo",
    ]
    .into_iter()
    {
        all_nearbys.push(get_nearby("", ty, &req.location).await?);
    }
    Ok(AOScheduleSuggest {
        ok: true,
        error: "",
        nearby: all_nearbys,
    })
}

pub async fn get_nearby(
    keyword: &str,
    ty: &str,
    location: &Location,
) -> Result<google_maps::places::place_search::text_search::response::Response, &'static str> {
    let client = reqwest::Client::new();
    let req = client
        .get("https://maps.googleapis.com/maps/api/place/nearbysearch/json")
        .query(&[
            (
                "location",
                &format!("{},{}", location.latitude, location.longitude) as &str,
            ),
            ("type", ty),
            ("keyword", keyword),
            ("radius", "1500"),
            ("key", GOOGLE_MAPS_API_KEY),
        ])
        .build()
        .map_err(|_| "Failed to build get_nearby")?;
    eprintln!("{}", req.url());
    let res = client
        .execute(req)
        .await
        .map_err(|_| "Failed to get get_nearby")?
        .text()
        .await
        .map_err(|_| "Failed to text-ify get_nearby")?;

    let response: google_maps::places::place_search::text_search::response::Response =
        serde_json::from_str(&res).map_err(|_| "Failed to parse into response get_nearby")?;

    Ok(response)
}
