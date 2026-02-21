import 'package:equatable/equatable.dart';
import '../data/models/notes_model.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

class NotesInitial extends NotesState {
  const NotesInitial();
}

class NotesLoading extends NotesState {
  const NotesLoading();
}

class NotesLoaded extends NotesState {
  final List<NotesModel> items;
  final bool isSyncing;
  final bool hasPendingSync;

  const NotesLoaded({
    required this.items,
    this.isSyncing = false,
    this.hasPendingSync = false,
  });

  NotesLoaded copyWith({
    List<NotesModel>? items,
    bool? isSyncing,
    bool? hasPendingSync,
  }) {
    return NotesLoaded(
      items: items ?? this.items,
      isSyncing: isSyncing ?? this.isSyncing,
      hasPendingSync: hasPendingSync ?? this.hasPendingSync,
    );
  }

  @override
  List<Object?> get props => [items, isSyncing, hasPendingSync];
}

class NotesError extends NotesState {
  final String message;
  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}
