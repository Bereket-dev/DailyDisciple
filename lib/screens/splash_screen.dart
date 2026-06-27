import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../constants/theme.dart';
import '../services/database_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    context.go('/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryNavy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '✝️',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 80,
                color: AppTheme.secondaryGold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Daily Disciple',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Grow in faith, one day at a time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.accentWarm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
