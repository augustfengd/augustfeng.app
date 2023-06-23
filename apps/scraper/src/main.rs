use fantoccini::ClientBuilder;
use futures::TryFutureExt;
use scraper::Html;

struct Program {
    client: fantoccini::Client,
}

#[derive(Debug)]
enum Error {
    ClientInitializationError(fantoccini::error::NewSessionError),
    WebDriverError(fantoccini::error::CmdError),
}

impl Program {
    async fn new() -> Result<Program, Error> {
        let cap = serde_json::map::Map::new().add(
            String::from("moz:firefoxOptions"),
            serde_json::json!({"args" : ["--headless"]}),
        );

        let client = ClientBuilder::native()
            .capabilities(cap)
            .connect("http://localhost:4444")
            .map_err(Error::ClientInitializationError)
            .await?;

        Ok(Program { client })
    }

    async fn run(self, url: &str) -> Result<Self, Error> {
        // let html = &self.get_html(url).await?;
        let html = Html::parse_document(" <div><div>a</div><div>b</div></div>");
        println!("{:#?}", html.tree);
        Ok(self)
    }

    async fn close(self) -> Result<(), Error> {
        self.client.close().map_err(Error::WebDriverError).await
    }

    async fn get_html(&self, url: &str) -> Result<Html, Error> {
        let text = self
            .client
            .goto(url)
            .and_then(|_| self.client.source())
            .map_err(Error::WebDriverError)
            .await?;

        Ok(Html::parse_document(&text))
    }
}

// I have the fluent interface itch
trait Add {
    fn add(self, k: String, v: serde_json::Value) -> Self;
}

impl Add for serde_json::map::Map<String, serde_json::Value> {
    fn add(mut self, k: String, v: serde_json::Value) -> Self {
        self.insert(k, v);
        self.to_owned()
    }
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    Program::new()
        .and_then(|s| {
            Program::run(
                s,
                "https://www.facebook.com/marketplace/montreal/search/?query=hx%20ergotron",
            )
        })
        .and_then(Program::close)
        .await
}
