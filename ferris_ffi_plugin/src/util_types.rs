#[repr(C)]
pub struct ByteArray {
    pub data: *const u8,
    pub len: usize,
}
