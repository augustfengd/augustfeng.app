#[derive(PartialEq, Debug)]
pub struct Listing {
    title: String,
    location: String,
    price: u32,
}

#[derive(Debug)]
pub enum ParsingError {
    SelectorErrorKind,
    ListingsNotFound,
    ListingNotFound,
    ListingDataNotFound,
    ListingDataFailure,
}

impl From<scraper::error::SelectorErrorKind<'_>> for ParsingError {
    fn from(_: scraper::error::SelectorErrorKind) -> Self {
        Self::SelectorErrorKind
    }
}

impl From<std::num::ParseIntError> for ParsingError {
    fn from(_: std::num::ParseIntError) -> Self {
        Self::ListingDataFailure
    }
}

pub fn find_listings_html(document: scraper::Html) -> Result<Vec<scraper::Html>, ParsingError> {
    let selector = scraper::Selector::parse("[style='max-width:1872px']")?;
    let mut it = document.select(&selector);

    let search_area_inside = it.next().ok_or(ParsingError::ListingsNotFound)?;
    // let search_area_outside = it.next().ok_or(ParsingError::ListingsNotFound)?;

    let selector = scraper::Selector::parse("a")?;
    let listings_html = search_area_inside.select(&selector);

    Ok(listings_html
        .map(|e| scraper::Html::parse_fragment(e.html().as_str()))
        .collect::<Vec<_>>())
}

pub fn build_listing(listing: scraper::Html) -> Result<Listing, ParsingError> {
    let selector = scraper::Selector::parse("span > div > span:first-child")?;

    let mut listing_data = listing.select(&selector);

    let price: u32 = listing_data
        .next()
        .and_then(|e| e.text().next())
        .ok_or(ParsingError::ListingDataNotFound)?
        .replace("C$", "")
        .replace(",", "")
        .parse()?;

    let title: String = listing_data
        .next()
        .and_then(|e| e.text().next())
        .ok_or(ParsingError::ListingDataNotFound)?
        .into();

    let location: String = listing_data
        .next()
        .and_then(|e| e.text().next())
        .ok_or(ParsingError::ListingDataNotFound)?
        .into();

    Ok(Listing {
        title,
        location,
        price,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    const LISTING_HTML: &str = r#"<div class="x9f619 x78zum5 x1r8uery xdt5ytf x1iyjqo2 xs83m0k x1e558r4 x150jy0e x1iorvi4 xjkvuk6 xnpuxes x291uyu x1uepa24" style="max-width: 381px; min-width: 242px;"><div class="xjp7ctv"><div><span class="x1lliihq x1iyjqo2"><div><div class="x3ct3a4"><a class="x1i10hfl xjbqb8w x6umtig x1b1mbwd xaqea5y xav7gou x9f619 x1ypdohk xt0psk2 xe8uvvx xdj266r x11i5rnm xat24cr x1mh8g0r xexx8yu x4uap5 x18d9i69 xkhd6sd x16tdsg8 x1hl2dhg xggy1nq x1a2a7pz x1heor9g x1lku1pv" href="/marketplace/item/1231535897484069/?ref=search&amp;referral_code=null&amp;referral_story_type=post&amp;tracking=browse_serp%3A39a1ccc2-ee98-4b87-b802-a950f38e13ad&amp;__tn__=!%3AD" role="link" tabindex="0"><div class="x78zum5 xdt5ytf x1n2onr6"><div class="x1n2onr6"><div class="x1n2onr6 xh8yej3"><div class="xzg4506 xycxndf xua58t2 x4xrfw5 xhk9q7s x1otrzb0 x1i1ezom x1o6z2jb x1ey2m1c xds687c x6ikm8r x10wlt62 x1n2onr6 x17qophe x13vifvy"><div class="xhk9q7s x1otrzb0 x1i1ezom x1o6z2jb x6ikm8r x10wlt62 x1vrad04 x1n2onr6 xh8yej3"><div class="x78zum5 x1a02dak x1c0ccdx x10l6tqk xzadtn0 x1pdr0v7 x9s46ru"><div class="x9f619 x78zum5 x1iyjqo2 x5yr21d x4p5aij x19um543 x1j85h84 x1m6msm x1n2onr6 xh8yej3"><img alt="Ergotron HX Tilt Pivot in Montréal, QC" class="xt7dq6l xl1xv1r x6ikm8r x10wlt62 xh8yej3" referrerpolicy="origin-when-cross-origin" src="https://scontent.fymq3-1.fna.fbcdn.net/v/t45.5328-4/347446360_6249040555174704_2883314192469406207_n.jpg?stp=c0.0.261.261a_dst-jpg_p261x260&amp;_nc_cat=103&amp;ccb=1-7&amp;_nc_sid=1a0e84&amp;_nc_ohc=mNqJmPSgiUQAX9aFVbx&amp;_nc_ht=scontent.fymq3-1.fna&amp;oh=00_AfDATJKhhG5ArQpLYquqHlNNQpwHDyFeW7WZU9TPqBKhGg&amp;oe=64A5C005"></div></div></div></div></div></div><div class="x9f619 x78zum5 xdt5ytf x1qughib x1rdy4ex xz9dl7a xsag5q8 xh8yej3 xp0eagm x1nrcals"><div class="x1gslohp xkh6y0r"><span class="x78zum5"><div class="x78zum5 x1q0g3np x1iorvi4 x4uap5 xjkvuk6 xkhd6sd"><span class="x193iq5w xeuugli x13faqbe x1vvkbs x1xmvt09 x1lliihq x1s928wv xhkezso x1gmr53x x1cpjm7i x1fgarty x1943h6x xudqn12 x676frb x1lkfr7t x1lbecb7 x1s688f xzsf02u" dir="auto">C$50</span></div></span></div><div class="x1gslohp xkh6y0r"><span aria-hidden="true"><div class="xyqdw3p x4uap5 xjkvuk6 xkhd6sd"><span class="x193iq5w xeuugli x13faqbe x1vvkbs x1xmvt09 x1lliihq x1s928wv xhkezso x1gmr53x x1cpjm7i x1fgarty x1943h6x xudqn12 x3x7a5m x6prxxf xvq8zen xo1l8bm xzsf02u" dir="auto"><span class="x1lliihq x6ikm8r x10wlt62 x1n2onr6" style="-webkit-box-orient: vertical; -webkit-line-clamp: 2; display: -webkit-box;">Ergotron HX Tilt Pivot</span></span></div></span></div><div class="x1gslohp xkh6y0r"><span aria-hidden="true"><div class="x1iorvi4 x4uap5 xjkvuk6 xkhd6sd"><span class="x193iq5w xeuugli x13faqbe x1vvkbs x1xmvt09 x1lliihq x1s928wv xhkezso x1gmr53x x1cpjm7i x1fgarty x1943h6x x4zkp8e x3x7a5m x1nxh6w3 x1sibtaa xo1l8bm xi81zsa" dir="auto"><span class="x1lliihq x6ikm8r x10wlt62 x1n2onr6 xlyipyv xuxw1ft x1j85h84">Montréal, QC</span></span></div></span></div></div></div></a></div></div></span></div></div></div>"#;

    #[test]
    fn test_build_listing() -> Result<(), ParsingError> {
        // arrange
        let fragment = scraper::Html::parse_fragment(LISTING_HTML);

        // act
        let listing = build_listing(fragment)?;

        // assert
        assert_eq!(
            listing,
            Listing {
                title: String::from("Ergotron HX Tilt Pivot"),
                location: String::from("Montréal, QC"),
                price: 50
            }
        );
        Ok(())
    }
}
