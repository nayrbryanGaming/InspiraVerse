import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/journal_storage_service.dart';
import '../../../core/services/local_storage_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          Text(
            'Inspiration Seeker',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Daily Notification'),
            trailing: Switch(value: true, onChanged: (v) {}),
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Quote Preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            trailing: Switch(value: false, onChanged: (v) {}),
          ),
          const Divider(height: 32),
          Text(
            'Data management',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.textTertiary),
          ),
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined, color: Colors.orangeAccent),
            title: const Text('Clear Local Cache'),
            subtitle: const Text('Purges all offline quotes and reflections'),
            onTap: () {
              JournalStorageService.clearAll();
              LocalStorageService.clearAll();
            },
          ),
          ListTile(
            leading: const Icon(Icons.no_accounts_outlined, color: Colors.redAccent),
            title: const Text('Delete My Account'),
            subtitle: const Text('Permanent removal of all personal data'),
            onTap: () {
              // Trigger deletion logic here
            },
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Rate the App'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
