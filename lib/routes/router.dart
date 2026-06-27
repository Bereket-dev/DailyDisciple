import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/home_screen.dart';
import '../screens/sermon_notes_screen.dart';
import '../screens/sermon_detail_screen.dart';
import '../screens/create_sermon_screen.dart';
import '../screens/reflection_screen.dart';
import '../screens/action_plan_screen.dart';
import '../screens/journal_screen.dart';
import '../screens/growth_dashboard_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

final goRouterProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'sermon-notes',
            builder: (context, state) => const SermonNotesScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateSermonScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return SermonDetailScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'reflection/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ReflectionScreen(sermonNoteId: id);
            },
          ),
          GoRoute(
            path: 'actions',
            builder: (context, state) => const ActionPlanScreen(),
          ),
          GoRoute(
            path: 'journal',
            builder: (context, state) => const JournalScreen(),
          ),
          GoRoute(
            path: 'growth',
            builder: (context, state) => const GrowthDashboardScreen(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
