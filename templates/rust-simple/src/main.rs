fn main() {
    println!("Hello, world!");
}

#[cfg(test)] // Ensures this module is only compiled when running tests
mod tests {
    #[test] // Marks this function as a test
    fn it_works() {
        assert_eq!(true, true);
    }
}
