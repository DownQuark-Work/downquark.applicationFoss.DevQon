pub fn add_to_waitlist() -> &'static str {"Added to waitlist"}
fn seat_at_table() {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn waiting() {
        assert_eq!(String::from("Added to waitlist"), add_to_waitlist());
    }
}