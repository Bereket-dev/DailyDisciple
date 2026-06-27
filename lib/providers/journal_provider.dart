import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/journal_entry.dart';
import '../services/database_service.dart';
import 'sermon_provider.dart';

final journalEntriesProvider = FutureProvider<List<JournalEntry>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getJournalEntries();
});

final journalEntriesByTypeProvider = FutureProvider.family<List<JournalEntry>, String>(
  (ref, type) async {
    final db = ref.watch(databaseServiceProvider);
    return db.getJournalEntriesByType(type);
  },
);

final journalEntriesStateProvider = StateNotifierProvider<JournalEntriesNotifier, List<JournalEntry>>(
  (ref) => JournalEntriesNotifier(ref.watch(databaseServiceProvider)),
);

class JournalEntriesNotifier extends StateNotifier<List<JournalEntry>> {
  final DatabaseService _db;

  JournalEntriesNotifier(this._db) : super([]);

  Future<void> addJournalEntry(JournalEntry entry) async {
    await _db.addJournalEntry(entry);
    await _reload();
  }

  Future<void> updateJournalEntry(JournalEntry entry) async {
    await _db.updateJournalEntry(entry);
    await _reload();
  }

  Future<void> deleteJournalEntry(int id) async {
    await _db.deleteJournalEntry(id);
    await _reload();
  }

  Future<void> loadJournalEntries() async {
    await _reload();
  }

  Future<void> _reload() async {
    final entries = await _db.getJournalEntries();
    state = entries;
  }
}
