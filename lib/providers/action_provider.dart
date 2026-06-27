import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/action_plan.dart';
import '../services/database_service.dart';
import 'sermon_provider.dart';

final actionPlansProvider = FutureProvider<List<ActionPlan>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getActionPlans();
});

final incompleteActionsProvider = FutureProvider<List<ActionPlan>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return db.getIncompleteActions();
});

final actionPlansStateProvider = StateNotifierProvider<ActionPlansNotifier, List<ActionPlan>>(
  (ref) => ActionPlansNotifier(ref.watch(databaseServiceProvider)),
);

class ActionPlansNotifier extends StateNotifier<List<ActionPlan>> {
  final DatabaseService _db;

  ActionPlansNotifier(this._db) : super([]);

  Future<void> addActionPlan(ActionPlan action) async {
    await _db.addActionPlan(action);
    await _reload();
  }

  Future<void> updateActionPlan(ActionPlan action) async {
    await _db.updateActionPlan(action);
    await _reload();
  }

  Future<void> deleteActionPlan(int id) async {
    await _db.deleteActionPlan(id);
    await _reload();
  }

  Future<void> loadActionPlans() async {
    await _reload();
  }

  Future<void> _reload() async {
    final actions = await _db.getActionPlans();
    state = actions;
  }
}
