#![feature(iterator_try_collect)]

use fantoccini::ClientBuilder;
use futures::TryFutureExt;

pub mod utils;
use utils::Add;

pub mod parser;
use parser::{build_listing, find_listings_html, ParsingError};

struct Program {
    client: fantoccini::Client,
}

#[derive(Debug)]
enum Error {
    ClientInitializationError(fantoccini::error::NewSessionError),
    WebDriverError(fantoccini::error::CmdError),
    ParserError(ParsingError),
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
        let html = self.get_html(url).await?;
        let listings_html = find_listings_html(html).map_err(Error::ParserError)?;

        println!(
            "a: {:#?}",
            listings_html
                .into_iter()
                .map(build_listing)
                .collect::<Vec<_>>()
        );
        Ok(self)
    }

    async fn close(self) -> Result<(), Error> {
        self.client.close().map_err(Error::WebDriverError).await
    }

    async fn get_html(&self, url: &str) -> Result<scraper::Html, Error> {
        let html = match std::fs::read_to_string("page.html").ok() {
            Some(data) => data,
            None => {
                self.client
                    .goto(url)
                    .and_then(|_| self.client.source())
                    .map_err(Error::WebDriverError)
                    .await?
            }
        };

        // std::fs::write("page.html", &html);

        Ok(scraper::Html::parse_document(&html))
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
