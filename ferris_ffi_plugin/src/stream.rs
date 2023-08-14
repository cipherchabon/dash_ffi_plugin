use allo_isolate::Isolate;
use std::thread;

/// # Safety
#[no_mangle]
pub unsafe extern "C" fn store_dart_post_cobject(
    port: unsafe extern "C" fn(i64, *mut allo_isolate::ffi::DartCObject) -> bool,
) {
    allo_isolate::store_dart_post_cobject(port);
}

#[no_mangle]
pub extern "C" fn start_rust_code(callback_port: i64) {
    println!("{}", callback_port);
    let isolate = Isolate::new(callback_port);

    thread::spawn(move || {
        for i in 1..=5 {
            println!("Enviando: {}", &i); // Añadir esta línea
            isolate.post(i);
            thread::sleep(std::time::Duration::from_secs(1));
        }
    });

    // for i in 1..=5 {
    //     let message = format!("Evento desde Rust: {}", i);
    //     println!("Enviando: {}", &message);
    //     isolate.post(message);
    //     thread::sleep(std::time::Duration::from_secs(1));
    // }
}
