import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/sermon_note.dart';
import '../services/database_service.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService());

final sermonNotesProvider = FutureProvider<List<SermonNote>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getSermonNotes();
});

final sermonNoteProvider = FutureProvider.family<SermonNote?, int>((ref, id) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getSermonNote(id);
});

final sermonNotesStateProvider = StateNotifierProvider<SermonNotesNotifier, List<SermonNote>>(
  (ref) => SermonNotesNotifier(ref.watch(databaseServiceProvider)),
);

class SermonNotesNotifier extends StateNotifier<List<SermonNote>> {
  final DatabaseService _db;

  SermonNotesNotifier(this._db) : super([]);

  Future<void> addSermonNote(SermonNote note) async {
    await _db.addSermonNote(note);
    final notes = await _db.getSermonNotes();
    state = notes;
  }

  Future<void> updateSermonNote(SermonNote note) async {
    await _db.updateSermonNote(note);
    final notes = await _db.getSermonNotes();
    state = notes;
  }

  Future<void> deleteSermonNote(int id) async {
    await _db.deleteSermonNote(id);
    final notes = await _db.getSermonNotes();
    state = notes;
  }

  Future<void> loadSermonNotes() async {
    final notes = await _db.getSermonNotes();
    state = notes;
  }
}
