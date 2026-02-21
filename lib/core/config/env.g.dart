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
    3275993020,
    938313871,
    1890049096,
    2999306135,
    1196177969,
    4079514529,
    2300257393,
    3800734434,
    2825882604,
    2898196007,
    1517677476,
  ];

  static const List<int> _envieddataapiKey = <int>[
    3275993048,
    938313962,
    1890049086,
    2999306184,
    1196178010,
    4079514564,
    2300257288,
    3800734397,
    2825882589,
    2898195989,
    1517677463,
  ];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}
