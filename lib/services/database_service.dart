import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/sermon_note.dart';
import '../models/action_plan.dart';
import '../models/journal_entry.dart';
import 'mock_data.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  late Isar isar;
  bool _initialized = false;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      // Initialize Isar with the models
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [],
        directory: dir.path,
      );
      _initialized = true;
      
      // Load mock data if database is empty
      await _loadMockDataIfEmpty();
    } catch (e) {
      print('Failed to initialize Isar: $e');
      // Fallback to in-memory storage
      _initialized = true;
    }
  }

  Future<void> _loadMockDataIfEmpty() async {
    // This is handled at app startup in main.dart
  }

  // Sermon Notes
  Future<void> addSermonNote(SermonNote note) async {
    // Store to file system (JSON)
    await _saveSermonNoteLocal(note);
  }

  Future<List<SermonNote>> getSermonNotes() async {
    return _loadSermonNotesLocal();
  }

  Future<SermonNote?> getSermonNote(int id) async {
    final notes = await _loadSermonNotesLocal();
    try {
      return notes.firstWhere((n) => n.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateSermonNote(SermonNote note) async {
    await _saveSermonNoteLocal(note);
  }

  Future<void> deleteSermonNote(int id) async {
    await _deleteSermonNoteLocal(id);
  }

  // Action Plans
  Future<void> addActionPlan(ActionPlan action) async {
    await _saveActionPlanLocal(action);
  }

  Future<List<ActionPlan>> getActionPlans() async {
    return _loadActionPlansLocal();
  }

  Future<List<ActionPlan>> getIncompleteActions() async {
    final actions = await _loadActionPlansLocal();
    return actions.where((a) => !a.isCompleted).toList();
  }

  Future<void> updateActionPlan(ActionPlan action) async {
    await _saveActionPlanLocal(action);
  }

  Future<void> deleteActionPlan(int id) async {
    await _deleteActionPlanLocal(id);
  }

  // Journal Entries
  Future<void> addJournalEntry(JournalEntry entry) async {
    await _saveJournalEntryLocal(entry);
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    return _loadJournalEntriesLocal();
  }

  Future<List<JournalEntry>> getJournalEntriesByType(String type) async {
    final entries = await _loadJournalEntriesLocal();
    return entries.where((e) => e.type == type).toList();
  }

  Future<void> updateJournalEntry(JournalEntry entry) async {
    await _saveJournalEntryLocal(entry);
  }

  Future<void> deleteJournalEntry(int id) async {
    await _deleteJournalEntryLocal(id);
  }

  // Local storage methods (using in-memory fallback)
  final List<SermonNote> _sermonNotes = [];
  final List<ActionPlan> _actionPlans = [];
  final List<JournalEntry> _journalEntries = [];

  Future<void> _saveSermonNoteLocal(SermonNote note) async {
    final index = _sermonNotes.indexWhere((n) => n.id == note.id);
    if (index >= 0) {
      _sermonNotes[index] = note;
    } else {
      _sermonNotes.add(note);
    }
  }

  Future<List<SermonNote>> _loadSermonNotesLocal() async {
    return _sermonNotes;
  }

  Future<void> _deleteSermonNoteLocal(int id) async {
    _sermonNotes.removeWhere((n) => n.id == id);
  }

  Future<void> _saveActionPlanLocal(ActionPlan action) async {
    final index = _actionPlans.indexWhere((a) => a.id == action.id);
    if (index >= 0) {
      _actionPlans[index] = action;
    } else {
      _actionPlans.add(action);
    }
  }

  Future<List<ActionPlan>> _loadActionPlansLocal() async {
    return _actionPlans;
  }

  Future<void> _deleteActionPlanLocal(int id) async {
    _actionPlans.removeWhere((a) => a.id == id);
  }

  Future<void> _saveJournalEntryLocal(JournalEntry entry) async {
    final index = _journalEntries.indexWhere((e) => e.id == entry.id);
    if (index >= 0) {
      _journalEntries[index] = entry;
    } else {
      _journalEntries.add(entry);
    }
  }

  Future<List<JournalEntry>> _loadJournalEntriesLocal() async {
    return _journalEntries;
  }

  Future<void> _deleteJournalEntryLocal(int id) async {
    _journalEntries.removeWhere((e) => e.id == id);
  }

  void loadMockData() {
    _sermonNotes.clear();
    _actionPlans.clear();
    _journalEntries.clear();
    _sermonNotes.addAll(MockData.getMockSermonNotes());
    _actionPlans.addAll(MockData.getMockActionPlans());
    _journalEntries.addAll(MockData.getMockJournalEntries());
  }
}
