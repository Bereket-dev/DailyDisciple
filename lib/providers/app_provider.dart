import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider = StateProvider<String>((ref) => 'Believer');
final streakCountProvider = StateProvider<int>((ref) => 5);
final completedActionsProvider = StateProvider<int>((ref) => 12);
final totalNotesProvider = StateProvider<int>((ref) => 8);
final themeProvider = StateProvider<bool>((ref) => false); // false = light, true = dark
