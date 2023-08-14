import 'package:dash_ffi_plugin/stream/stream.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Streamer', () {
    test('emits messages sent from Rust', () async {
      final streamer = Streamer();

      // Almacenar los mensajes emitidos en una lista
      final emittedMessages = [];
      final subscription = streamer().listen(emittedMessages.add);

      // Espera a que todos los eventos sean procesados
      await Future.delayed(const Duration(seconds: 10));

      // Limpieza
      subscription.cancel();
      streamer.dispose();

      // Verifica si los mensajes fueron emitidos
      for (int i = 1; i <= 5; i++) {
        expect(emittedMessages, contains('Evento desde Rust: $i'));
      }
    });
  });
}
