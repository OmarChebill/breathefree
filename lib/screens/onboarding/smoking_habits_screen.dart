import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../theme/app_theme.dart';
import '../../widgets/onboarding_scaffold.dart';
import 'quit_date_screen.dart';

class SmokingHabitsScreen extends StatefulWidget {
  const SmokingHabitsScreen({super.key, required this.draft});
  final UserProfile draft;

  @override
  State<SmokingHabitsScreen> createState() => _SmokingHabitsScreenState();
}

class _SmokingHabitsScreenState extends State<SmokingHabitsScreen> {
  int _perDay = 10;
  double _years = 5;
  final _price = TextEditingController();

  double? get _priceValue =>
      double.tryParse(_price.text.trim().replaceAll(',', '.'));

  @override
  void dispose() {
    _price.dispose();
    super.dispose();
  }

  void _next() {
    final updated = widget.draft.copyWith(
      cigarettesPerDay: _perDay,
      packPrice: _priceValue,
      yearsSmoking: _years.round(),
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => QuitDateScreen(draft: updated)));
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final valid = (_priceValue ?? 0) > 0;

    return OnboardingScaffold(
      step: 2,
      title: 'Your smoking habits',
      subtitle: 'Honest numbers give you accurate savings and health stats.',
      buttonLabel: 'Continue',
      onNext: valid ? _next : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SoftCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Cigarettes per day', style: t.bodyMedium),
                  Text('$_perDay', style: t.headlineMedium),
                ]),
                Row(children: [
                  IconButton.filledTonal(
                    onPressed: _perDay > 1 ? () => setState(() => _perDay--) : null,
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    style: IconButton.styleFrom(backgroundColor: AppColors.pine),
                    onPressed: _perDay < 100 ? () => setState(() => _perDay++) : null,
                    icon: const Icon(Icons.add),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SoftCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Years of smoking: ${_years.round()}', style: t.bodyMedium),
              Slider(
                value: _years,
                min: 1,
                max: 50,
                divisions: 49,
                activeColor: AppColors.pine,
                onChanged: (v) => setState(() => _years = v),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Text('Price of one pack (20 cigarettes)', style: t.bodyMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _price,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'e.g. 7.5'),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
    );
  }
}