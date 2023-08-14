typedef struct ByteArray {
  const uint8_t *data;
  uintptr_t len;
} ByteArray;

typedef struct NativeResponse {
  uint32_t code;
  const char *body;
} NativeResponse;

char get_max_c_char(void);

char get_min_c_char(void);

const char *get_c_str(void);

/**
 * # Safety
 *
 * The `name` argument must be a valid, non-null pointer to a null-terminated C string.
 * It is the caller's responsibility to ensure that the pointer is valid.
 * Calling this function with an invalid or null pointer will result in undefined behavior.
 */
char *get_hello_world_with_name(const char *name);

double get_default_c_double(void);

float get_default_c_float(void);

int get_max_c_int(void);

int get_min_c_int(void);

long get_max_c_long(void);

long get_min_c_long(void);

long long get_max_c_longlong(void);

long long get_min_c_longlong(void);

signed char get_max_c_schar(void);

signed char get_min_c_schar(void);

short get_max_c_short(void);

short get_min_c_short(void);

unsigned char get_max_c_uchar(void);

unsigned char get_min_c_uchar(void);

unsigned int get_max_c_uint(void);

unsigned int get_min_c_uint(void);

unsigned long get_max_c_ulong(void);

unsigned long get_min_c_ulong(void);

/**
 * # Safety
 * The returned pointer must be freed with `free_c_char_ptr`.
 */
char *get_max_c_ulong_as_string(void);

struct ByteArray get_max_c_ulong_as_bytes(void);

unsigned long long get_max_c_ulonglong(void);

unsigned long long get_min_c_ulonglong(void);

/**
 * # Safety
 * The returned pointer must be freed with `free_c_char_ptr`.
 */
char *get_max_c_ulonglong_as_string(void);

struct ByteArray get_max_c_ulonglong_as_bytes(void);

unsigned short get_max_c_ushort(void);

unsigned short get_min_c_ushort(void);

struct NativeResponse get_response(void);

/**
 * # Safety
 *
 * The `response` argument must be a valid, non-null pointer to a Response.
 * It is the caller's responsibility to ensure that the pointer is valid.
 * Calling this function with an invalid or null pointer will result in
 * undefined behavior.
 *
 * Make sure not to use the pointer after it has been freed, as it will no
 * longer be valid.
 */
void free_response(struct NativeResponse *response);

int sum_long_running(int a, int b);

/**
 * # Safety
 * It is the caller's responsibility to ensure that the pointer is valid.
 */
void free_c_char_ptr(char *ptr);

/**
 * # Safety
 * It is the caller's responsibility to ensure that the pointer is valid.
 */
void free_byte_array(struct ByteArray arr);

/**
 * # Safety
 */
void store_dart_post_cobject(bool (*port)(int64_t, DartCObject*));

void start_rust_code(int64_t callback_port);
