import 'package:flutter/material.dart';
import 'package:flutter_application_88/data/local/app_database.dart';

class SettingsPage extends StatelessWidget {
  final AppDatabase database;

  const SettingsPage({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 32),
              _buildSettingsTile(
                title: 'Share this app',
                onTap: () {},
              ),
              _buildSettingsTile(
                title: 'Rate us',
                onTap: () {},
              ),
              _buildSettingsTile(
                title: 'Leave feedback',
                onTap: () {},
              ),
              _buildSettingsTile(
                title: 'Clear history',
                isPurple: true,
                onTap: () async {
                  await database.clearAllResults();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('История успешно очищена')),
                  );
                },
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'v 1.0.0',
                  style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required VoidCallback onTap,
    bool isPurple = false,
  }) {
    final textColor = isPurple ? const Color(0xFF8E6CFF) : Colors.black87;
    final arrowColor = isPurple ? const Color(0xFF8E6CFF).withValues(alpha: 0.7) : Colors.black26;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: arrowColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}