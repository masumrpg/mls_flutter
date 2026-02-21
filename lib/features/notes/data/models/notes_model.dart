import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/database/app_database.dart';

class NotesModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotesModel({
    required this.id,
    required this.title,
    this.description = '',
    this.isSynced = false,
    required this.createdAt,
    required this.updatedAt,
  });

  NotesModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ─── JSON Serialization ──────────────────────────────────────────────────

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      isSynced: true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // ─── Drift Mappers ───────────────────────────────────────────────────────

  /// Drift entity → Domain model
  factory NotesModel.fromDrift(NotesItem item) {
    return NotesModel(
      id: item.id,
      title: item.title,
      description: item.description,
      isSynced: item.isSynced,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  /// Domain model → Drift Companion (for insert/update)
  NotesItemsCompanion toDriftCompanion() {
    return NotesItemsCompanion.insert(
      id: id,
      title: title,
      description: Value(description),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, isSynced, createdAt, updatedAt];
}
