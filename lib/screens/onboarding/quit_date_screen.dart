import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_scaffold.dart';
import 'onboarding_complete_screen.dart';

class QuitDateScreen extends StatefulWidget {
  const QuitDateScreen({super.key, required this.draft});
  final UserProfile draft;

  @override
  State<QuitDateScreen> createState() => _QuitDateScreenState();
}

class _QuitDateScreenState extends State<QuitDateScreen> {
  bool _today = true;
  DateTime _date = DateTime.now();

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 60)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _next() {
    final updated = widget.draft.copyWith(quitDate: _today ? DateTime.now() : _date);
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => OnboardingCompleteScreen(profile: updated)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final dateLabel = MaterialLocalizations.of(context).formatMediumDate(_date);

    return OnboardingScaffold(
      step: 3,
      title: 'When is your quit date?',
      subtitle: 'Already quit? Pick the day you had your last cigarette.',
      buttonLabel: 'Continue',
      onNext: _next,
      child: Column(children: [
        SoftCard(
          highlighted: _today,
          onTap: () => setState(() => _today = true),
          child: Text('I quit today', style: t.titleMedium),
        ),
        const SizedBox(height: 12),
        SoftCard(
          highlighted: !_today,
          onTap: () {
            setState(() => _today = false);
            _pickDate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pick another date', style: t.titleMedium),
              Text(_today ? '' : dateLabel,
                  style: t.bodyMedium?.copyWith(color: AppColors.pine)),
            ],
          ),
        ),
      ]),
    );
  }
}