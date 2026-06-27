import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_widgets.dart';
import '../constants/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Take Notes',
      'subtitle': 'Capture sermon insights, scriptures, and key points',
      'icon': '📝',
    },
    {
      'title': 'Reflect & Learn',
      'subtitle': 'AI-powered reflections on spiritual lessons',
      'icon': '🤔',
    },
    {
      'title': 'Take Action',
      'subtitle': 'Convert sermons into actionable daily tasks',
      'icon': '✨',
    },
    {
      'title': 'Track Growth',
      'subtitle': 'Visualize your spiritual journey and progress',
      'icon': '📈',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final page = pages[index];
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(page['icon']!, style: const TextStyle(fontSize: 80)),
                      const SizedBox(height: 32),
                      Text(
                        page['title']!,
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page['subtitle']!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textMuted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _currentPage
                            ? AppTheme.primaryNavy
                            : AppTheme.dividerLight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: _currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                  onPressed: () {
                    if (_currentPage == pages.length - 1) {
                      context.go('/home');
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
