import 'package:equatable/equatable.dart';
import '../data/models/notes_model.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

/// Initialize: subscribe to DB stream + connectivity
class NotesStarted extends NotesEvent {
  const NotesStarted();
}

/// User adds a new item
class NotesAdded extends NotesEvent {
  final NotesModel item;
  const NotesAdded(this.item);

  @override
  List<Object?> get props => [item];
}

/// User updates an item
class NotesUpdated extends NotesEvent {
  final NotesModel item;
  const NotesUpdated(this.item);

  @override
  List<Object?> get props => [item];
}

/// User deletes an item
class NotesDeleted extends NotesEvent {
  final String id;
  const NotesDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

/// Trigger sync (manual or auto on reconnect)
class NotesSyncRequested extends NotesEvent {
  const NotesSyncRequested();
}
