use wasm_bindgen::prelude::*; // Import js_sys for working with JavaScript arrays

// Function to add two numbers
#[wasm_bindgen]
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[wasm_bindgen]
pub fn hello_world() -> JsValue {
    let greeting = "Hello, World!";
    JsValue::from_str(greeting)
}

#[wasm_bindgen]
pub fn bye_world() -> JsValue {
    let greeting = "Bye, World!";
    JsValue::from_str(greeting)
}

// Function to return a list of two integers
#[wasm_bindgen]
pub fn return_two_ints() -> JsValue {
    // Create a JavaScript array with two integers
    let result = js_sys::Array::new();
    result.push(&JsValue::from(1)); // First integer
    result.push(&JsValue::from(2)); // Second integer
    result.into()
}

#[wasm_bindgen]
pub fn string_length(ptr: usize) -> i32 {
    let mut length = 0;
    let mut current = ptr as *const u8;

    // Traverse memory until we find a null terminator
    while unsafe { *current } != 0 {
        length += 1;
        current = unsafe { current.add(1) }; // Move to the next byte
    }

    length as i32 // Convert usize to i32
}

// #[wasm_bindgen]
// pub fn string_length(input: &str) -> i32 {
//     input.len() as i32 // Convert usize to i32
// }

// // Function to return the length of a given string as an i32
// #[wasm_bindgen]
// pub fn string_length(input: JsValue) -> i32 {
//     // Debug print to see the type of the input
//     if !input.is_string() {
//         return -1; // Return -1 for non-string inputs to indicate an error
//     }

//     let js_string: String = input.as_string().unwrap(); // Safely unwrap since we checked
//     js_string.len() as i32 // Convert usize to i32
// }
