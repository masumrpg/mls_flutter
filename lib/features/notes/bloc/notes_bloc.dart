import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../domain/repositories/notes_repository.dart';
import '../data/models/notes_model.dart';
import 'notes_event.dart';
import 'notes_state.dart';

/// Internal event: Drift stream emitted new data
class _NotesDataChanged extends NotesEvent {
  final List<NotesModel> items;
  const _NotesDataChanged(this.items);

  @override
  List<Object?> get props => [items];
}

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository repository;
  final Connectivity connectivity;

  StreamSubscription<List<NotesModel>>? _dataSubscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  NotesBloc({
    required this.repository,
    required this.connectivity,
  }) : super(const NotesInitial()) {
    on<NotesStarted>(_onStarted);
    on<NotesAdded>(_onAdded);
    on<NotesUpdated>(_onUpdated);
    on<NotesDeleted>(_onDeleted);
    on<NotesSyncRequested>(_onSyncRequested);
    on<_NotesDataChanged>(_onDataChanged);
  }

  Future<void> _onStarted(
    NotesStarted event,
    Emitter<NotesState> emit,
  ) async {
    emit(const NotesLoading());

    // Subscribe to Drift stream
    _dataSubscription = repository.watchAll().listen(
      (items) => add(_NotesDataChanged(items)),
    );

    // Subscribe to connectivity changes
    _connectivitySubscription = connectivity.onConnectivityChanged.listen(
      (results) {
        if (!results.contains(ConnectivityResult.none)) {
          // Back online → auto sync
          add(const NotesSyncRequested());
        }
      },
    );
  }

  void _onDataChanged(
    _NotesDataChanged event,
    Emitter<NotesState> emit,
  ) {
    final hasPending = event.items.any((item) => !item.isSynced);
    final currentState = state;

    emit(NotesLoaded(
      items: event.items,
      isSyncing: currentState is NotesLoaded
          ? currentState.isSyncing
          : false,
      hasPendingSync: hasPending,
    ));
  }

  Future<void> _onAdded(
    NotesAdded event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await repository.add(event.item);
      // No need to emit — Drift stream will update automatically
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onUpdated(
    NotesUpdated event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await repository.update(event.item);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onDeleted(
    NotesDeleted event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await repository.delete(event.id);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onSyncRequested(
    NotesSyncRequested event,
    Emitter<NotesState> emit,
  ) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      emit(currentState.copyWith(isSyncing: true));
    }

    try {
      await repository.syncPendingChanges();
    } catch (_) {
      // Sync failed silently — will retry
    }

    final afterState = state;
    if (afterState is NotesLoaded) {
      emit(afterState.copyWith(isSyncing: false));
    }
  }

  @override
  Future<void> close() {
    _dataSubscription?.cancel();
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
