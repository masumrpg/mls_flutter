// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: env/.env.development
final class _Env {
  static const String apiBaseUrl = 'https://api.myquran.com/v3';

  static const List<int> _enviedkeyapiKey = <int>[
    1154491653,
    3857439443,
    2045177232,
    3363233590,
    2575069949,
    1266995716,
    3428954583,
    4294753072,
    3784018052,
    3477655272,
    3881619652,
  ];

  static const List<int> _envieddataapiKey = <int>[
    1154491745,
    3857439414,
    2045177318,
    3363233641,
    2575069846,
    1266995809,
    3428954542,
    4294753135,
    3784018101,
    3477655258,
    3881619703,
  ];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}
