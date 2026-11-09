import 'package:flutter/material.dart';
import 'models/user_profile.dart';
import 'screens/onboarding/welcome_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // needed before async work in main
  final profile = await StorageService.loadProfile();
  runApp(BreatheFreeApp(profile: profile));
}

class BreatheFreeApp extends StatelessWidget {
  const BreatheFreeApp({super.key, this.profile});
  final UserProfile? profile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BreatheFree',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Already onboarded? Skip straight to home.
      home: profile == null ? const WelcomeScreen() : HomePlaceholder(profile: profile!),
    );
  }
}

/// Temporary screen. We replace it with the real Dashboard in phase 3.
class HomePlaceholder extends StatelessWidget {
  const HomePlaceholder({super.key, required this.profile});
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard for ${profile.name} coming next',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
      ),
    );
  }
}