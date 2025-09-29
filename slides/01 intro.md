# Rust Lesson 1

## Intro to Rust Programming

---

# Functions

- Functions are declared with `fn`
- Parameters must be typed
- The return type is declared with `->`

```rust
fn add(x: i32, y: i32) -> i32 {
    x + y
}

fn main() {
    let sum = add(2, 3);
    println!("Sum is {}", sum);
}
```

---

# Expression-Based Language

- Rust is expression-oriented
- Most things return a value
- No semicolon → value is returned

```rust
fn square(x: i32) -> i32 {
    x * x  // no semicolon → expression result
}

fn main() {
    let temp = "hi";
    let y = {
        let temp = 5;
        // temp = 5
        temp + 1  // block returns 6
    };
    // temp = "hi"
    println!("{}", y);
}
```

---

# Macros

- Macros look like functions but end with `!`
- They generate code at compile time
- Example:
  `println!` is a macro

```rust
fn main() {
    println!("Hello, world!"); // macro, not function

    let value = "The value";
    dgb!(value); // prints: value = "The value"
}
```

- Useful for:
  - Debugging (`dbg!`)
  - Code generation (`vec!`, `format!`)

---

# Struct vs Class (1/3)

- Rust does **not** have classes
- Instead:
  **structs** for data, **impl blocks** for methods
- No inheritance → use traits instead

```rust
// Named-field struct
struct Point {
    x: f64,
    y: f64,
}

fn main() {
    let p = Point { x: 3.0, y: 4.0 };
    println!("Point({}, {})", p.x, p.y);
}
```

---

# Struct vs Class (2/3)

- Tuple structs:
  unnamed fields, accessed by index

```rust
struct Color(u8, u8, u8);

fn main() {
    let red = Color(255, 0, 0);
    println!("({}, {}, {})", red.0, red.1, red.2);
}
```

---

# Struct vs Class (3/3)

- Unit structs:
  no fields at all
- Often used as markers or for traits

```rust
struct Marker;

fn main() {
    let _m = Marker;
}
```

---

# Impl Blocks

- Attach methods to structs with `impl`

```rust
struct Point {
    x: f64,
    y: f64,
}

impl Point {
    fn distance(&self) -> f64 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}

fn main() {
    let p = Point { x: 3.0, y: 4.0 };
    println!("{}", p.distance());
}
```

---

# Traits

- Traits = interfaces
- Define shared behavior
- Types implement traits with `impl Trait for Type`

```rust
trait Speak {
    fn speak(&self);
}

struct Dog;

impl Speak for Dog {
    fn speak(&self) {
        println!("Woof!");
    }
}
```

---

# Enums (1/2)

- Enums let you define **multiple possible variants**
- Variants can store values

```rust
enum Direction {
    Up,
    Down,
    Left,
    Right,
}
```

---

# Enums (2/2)

- Variants can carry **different data**

```rust
enum Message {
    Quit,                     // no data
    Write(String),            // one piece of data
    Move { x: i32, y: i32 },  // named fields
}

fn handle(msg: Message) {
    match msg {
        Message::Quit => println!("Quit"),
        Message::Write(text) => println!("Text: {}", text),
        Message::Move { x, y } => println!("Move to ({}, {})", x, y),
    }
}
```

---

# Ownership (1/4)

- Rust’s core feature:
  **memory safety without GC**
- Every value has a **single owner**
- When the owner goes out of scope, the value is dropped

```rust
fn main() {
    let s = String::from("hello");
    println!("{}", s);
} // s is freed here
```

---

# Ownership (2/4) – Move Semantics

- Assignment or passing a variable **moves** ownership
- After a move, the old variable cannot be used

```rust
fn main() {
    let s1 = String::from("hello");
    let s2 = s1;  // ownership moved
    // println!("{}", s1); // ❌ error: s1 no longer valid
    println!("{}", s2);
}
```

---

# Ownership (3/4) – Borrowing

- Instead of moving, you can **borrow** with references
- Immutable borrow:
  `&T`  
- Multiple immutable borrows allowed

```rust
fn print_len(s: &String) {
    println!("Length is {}", s.len());
}

fn main() {
    let s = String::from("hello");
    print_len(&s);  // borrow
    println!("{}", s); // still valid
}
```

---

# Ownership (4/4) – Mutable Borrowing

- At most **one mutable borrow** at a time
- Prevents data races at compile time

```rust
fn add_exclamation(s: &mut String) {
    s.push('!');
}

fn main() {
    let mut s = String::from("hello");
    add_exclamation(&mut s);
    println!("{}", s);
}
```

---

# Rust’s Greatness

- Rust is designed for **reliability and safety**
- Key guarantees:
  - **No null pointers**
  - **No unchecked exceptions**
  - **No data races**
  - **No use-after-free**

---

# No Null – `Option<T>`

- In Rust, there is no `null`
- Instead, optional values use the `Option<T>` type

```rust
fn find_user(id: u32) -> Option<String> {
    if id == 1 {
        Some(String::from("Alice"))
    } else {
        None
    }
}

fn main() {
    match find_user(1) {
        Some(name) => println!("User: {}", name),
        None => println!("Not found"),
    }
}
```

---

# No Exceptions – `Result<T, E>`

- Rust does not have exceptions
- Errors are represented with `Result<T, E>`

```rust
fn divide(a: f64, b: f64) -> Result<f64, String> {
    if b == 0.0 {
        Err("Cannot divide by zero".to_string())
    } else {
        Ok(a / b)
    }
}

fn main() {
    match divide(10.0, 2.0) {
        Ok(v) => println!("Result = {}", v),
        Err(e) => println!("Error: {}", e),
    }
}
```

---

# Why It Matters

- **Enums** make `Option` and `Result` possible
- **No Null** → forces you to handle “value may not exist”  
- **No Exceptions** → error handling is explicit and type-checked  
- **Ownership model** → prevents memory leaks, data races, dangling pointers  

✅ Result:
**Programs that don’t randomly crash at runtime**
