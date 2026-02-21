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
    1134129541,
    4234884501,
    3542266325,
    552417204,
    700833178,
    934495143,
    4289744557,
    556034855,
    1707527684,
    715650677,
    1427379915,
  ];

  static const List<int> _envieddataapiKey = <int>[
    1134129633,
    4234884592,
    3542266275,
    552417259,
    700833265,
    934495170,
    4289744596,
    556034936,
    1707527733,
    715650631,
    1427379960,
  ];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}
