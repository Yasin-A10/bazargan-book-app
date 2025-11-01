import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:typed_data';

Future<Uint8List> decryptFile(Uint8List encryptedData, String key) async {
  try {
    // Extract IV (first 16 bytes)
    final iv = encrypt.IV(encryptedData.sublist(0, 16));
    final ciphertext = encryptedData.sublist(16);

    final keyBytes = encrypt.Key.fromUtf8(key.padRight(32, '\u0000'));
    final encrypter = encrypt.Encrypter(
      encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc),
    );

    final decryptedData = encrypter.decryptBytes(
      encrypt.Encrypted(ciphertext),
      iv: iv,
    );

    return Uint8List.fromList(decryptedData);
  } catch (e) {
    print('Decryption failed: $e');
    throw Exception('Decryption failed: Invalid key or corrupted data');
  }
}
