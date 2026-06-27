import 'package:flutter/material.dart';
import '../widgets/app_widgets.dart';
import '../constants/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool notifications = true;
  String fontSize = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _settingSection(
              context,
              'Display',
              [
                _switchSetting('Dark Mode', darkMode, (value) {
                  setState(() => darkMode = value);
                }),
                const SizedBox(height: 12),
                _settingDropdown(
                  'Font Size',
                  fontSize,
                  ['Small', 'Medium', 'Large'],
                  (value) => setState(() => fontSize = value),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _settingSection(
              context,
              'Notifications',
              [
                _switchSetting('Daily Reminders', notifications, (value) {
                  setState(() => notifications = value);
                }),
                const SizedBox(height: 12),
                _switchSetting('Weekly Summary', true, (value) {}),
              ],
            ),
            const SizedBox(height: 24),
            _settingSection(
              context,
              'About',
              [
                _settingInfo('Version', '1.0.0'),
                const SizedBox(height: 12),
                _settingInfo('Build', '1'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingSection(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        AppCard(
          padding: const EdgeInsets.all(16),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _switchSetting(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _settingDropdown(
    String title,
    String value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        DropdownButton<String>(
          value: value,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: (val) => onChanged(val ?? value),
        ),
      ],
    );
  }

  Widget _settingInfo(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value, style: const TextStyle(color: AppTheme.textMuted)),
      ],
    );
  }
}
