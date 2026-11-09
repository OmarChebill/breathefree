import 'package:flutter/material.dart';
import '../../main.dart' show HomePlaceholder;
import '../../models/user_profile.dart';
import '../../services/storage_service.dart';
import '../../theme/app_theme.dart';
import '../../utils/calculations.dart';
import '../../widgets/onboarding_scaffold.dart';

class OnboardingCompleteScreen extends StatelessWidget {
  const OnboardingCompleteScreen({super.key, required this.profile});
  final UserProfile profile;

  Future<void> _finish(BuildContext context) async {
    await StorageService.saveProfile(profile);
    if (!context.mounted) return; // safety check after an await
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomePlaceholder(profile: profile)),
      (route) => false, // clears onboarding so Back can't return to it
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final daily = Calculations.dailySavings(profile);

    Widget stat(String value, String label) => SoftCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: t.bodyMedium),
              Text(value, style: t.headlineMedium?.copyWith(color: AppColors.pine)),
            ],
          ),
        );

    return OnboardingScaffold(
      step: 4,
      title: "You're set, ${profile.name}",
      subtitle: 'Here is what staying smoke-free will give you.',
      buttonLabel: 'Start my journey',
      onNext: () => _finish(context),
      child: Column(children: [
        stat('${profile.cigarettesPerDay}', 'Cigarettes avoided per day'),
        const SizedBox(height: 12),
        stat(daily.toStringAsFixed(2), 'Saved per day'),
        const SizedBox(height: 12),
        stat((daily * 365).toStringAsFixed(0), 'Saved in one year'),
      ]),
    );
  }
}