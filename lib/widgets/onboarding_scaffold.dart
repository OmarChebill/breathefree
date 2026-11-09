import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'custom_button.dart';

/// The shared layout of every onboarding screen:
/// progress bar on top, title, content, button at the bottom.
class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.buttonLabel,
    required this.onNext,
    this.canGoBack = true,
  });

  static const totalSteps = 4;

  final int step; // 1 to 4
  final String title;
  final String subtitle;
  final Widget child;
  final String buttonLabel;
  final VoidCallback? onNext;
  final bool canGoBack;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 24, 24),
          child: Column(
            children: [
              Row(children: [
                SizedBox(
                  width: 48,
                  child: canGoBack
                      ? IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back_rounded))
                      : null,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: step / totalSteps,
                      minHeight: 6,
                      backgroundColor: Colors.white,
                      color: AppColors.pine,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: t.headlineLarge),
                      const SizedBox(height: 10),
                      Text(subtitle,
                          style: t.bodyLarge?.copyWith(color: AppColors.stone)),
                      const SizedBox(height: 32),
                      child,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CustomButton(label: buttonLabel, onPressed: onNext),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// White rounded container used for grouped content.
class SoftCard extends StatelessWidget {
  const SoftCard({super.key, required this.child, this.highlighted = false, this.onTap});

  final Widget child;
  final bool highlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: highlighted ? AppColors.pine : Colors.transparent, width: 2),
        ),
        child: child,
      ),
    );
  }
}