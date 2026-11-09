import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../widgets/onboarding_scaffold.dart';
import 'smoking_habits_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose(); // always free controllers
    super.dispose();
  }

  void _next() {
    // Start the draft profile; later screens fill in the rest.
    final draft = UserProfile(
      name: _name.text.trim(),
      cigarettesPerDay: 10,
      packPrice: 0,
      yearsSmoking: 5,
      quitDate: DateTime.now(),
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SmokingHabitsScreen(draft: draft)));
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      step: 1,
      canGoBack: false,
      title: 'Welcome to BreatheFree',
      subtitle: 'A few quick questions so we can track your progress and savings. What should we call you?',
      buttonLabel: 'Continue',
      // setState in onChanged rebuilds the screen, so the button enables itself.
      onNext: _name.text.trim().isEmpty ? null : _next,
      child: TextField(
        controller: _name,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(hintText: 'Your first name'),
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}