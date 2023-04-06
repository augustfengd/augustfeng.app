#[derive(serde::Deserialize, Debug)]
pub struct Token {
    pub access_token: String,
}

#[derive(serde::Serialize, Debug)]
pub struct ResourceRecordSetsUpdateMask {
    pub paths: Vec<String>,
}

#[derive(serde::Serialize, Debug)]
pub struct ResourceRecordSets {
    pub rrdatas: Vec<String>,
    pub update_mask: ResourceRecordSetsUpdateMask,
}
