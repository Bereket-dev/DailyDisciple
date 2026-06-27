import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_widgets.dart';
import '../constants/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryNavy,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text('👤', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 50)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Welcome, Disciple', style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Text('Your faith journey awaits', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Days Active', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Text('24', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.primaryNavy)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Streak', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Text('5 🔥', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.successGreen)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _menuItem(context, 'Growth Dashboard', '📈', () => context.push('/home/growth')),
                  const SizedBox(height: 8),
                  _menuItem(context, 'Settings', '⚙️', () => context.push('/home/profile/settings')),
                  const SizedBox(height: 8),
                  _menuItem(context, 'About', 'ℹ️', () => _showAboutDialog(context)),
                  const SizedBox(height: 8),
                  _menuItem(context, 'Help & Support', '❓', () => _showSupportDialog(context)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SecondaryButton(
                label: 'Log Out',
                onPressed: () => context.go('/onboarding'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String title, String icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Daily Disciple'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version 1.0.0', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Daily Disciple helps Christians capture sermon insights and apply biblical teachings to daily life.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text('Built with ❤️ for disciples of Jesus Christ', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: support@dailydisciple.com', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Text('Visit our website for more resources', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
