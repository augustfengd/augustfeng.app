pub trait Add {
    fn add(self, k: String, v: serde_json::Value) -> Self;
}

impl Add for serde_json::map::Map<String, serde_json::Value> {
    fn add(mut self, k: String, v: serde_json::Value) -> Self {
        self.insert(k, v);
        self.to_owned()
    }
}
