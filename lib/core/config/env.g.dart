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
    1195422284,
    1894160514,
    263296891,
    607497857,
    1552012148,
    626359495,
    2513830738,
    2660195641,
    2844203831,
    3665437737,
    3089928861,
  ];

  static const List<int> _envieddataapiKey = <int>[
    1195422248,
    1894160615,
    263296781,
    607497950,
    1552012063,
    626359458,
    2513830699,
    2660195686,
    2844203782,
    3665437723,
    3089928878,
  ];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}
