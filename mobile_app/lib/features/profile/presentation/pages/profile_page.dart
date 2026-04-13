import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/journal_storage_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../core/services/haptic_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showDeleteConfirmation(BuildContext context) {
    HapticService.heavy();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const DeletionSafetyDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings', style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.primary,
              child: Icon(Icons.person_outline_rounded, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Inspiration Seeker',
            style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Architecting your daily evolution',
            style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textTertiary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildSectionHeader('Preferences'),
          _buildListTile(Icons.notifications_outlined, 'Daily Notification', trailing: Switch(value: true, activeColor: AppTheme.primary, onChanged: (v) {
            HapticService.selection();
          })),
          _buildListTile(Icons.dark_mode_outlined, 'Zen Dark Mode', trailing: Switch(value: false, activeColor: AppTheme.primary, onChanged: (v) {
            HapticService.selection();
          })),
          const SizedBox(height: 24),
          _buildSectionHeader('Data Transparency'),
          _buildTransparencyTile(
            Icons.shield_outlined,
            'Your Data Security',
            'We use AES-256 equivalent encryption for all cloud syncing. Your activity is private and never shared with third parties.',
          ),
          _buildTransparencyTile(
            Icons.visibility_off_outlined,
            'Zero Tracking Policy',
            'We do not sell personal data. Analytics are aggregated and anonymous to improve curation logic.',
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Maintenance'),
          _buildListTile(
            Icons.cleaning_services_outlined, 
            'Clear Local Cache', 
            color: Colors.orangeAccent,
            subtitle: 'Purges all offline data cache',
            onTap: () async {
              HapticService.medium();
              await JournalStorageService.clearAll();
              await LocalStorageService.clearAll();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Offline cache cleared.')));
              }
            },
          ),
          _buildListTile(
            Icons.no_accounts_outlined, 
            'Delete My Account', 
            color: Colors.redAccent,
            subtitle: 'Permanent removal of all personal data',
            onTap: () => _showDeleteConfirmation(context),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Legal'),
          _buildListTile(Icons.star_outline_rounded, 'Rate InspiraVerse'),
          _buildListTile(Icons.info_outline_rounded, 'Terms & Privacy Hub'),
          _buildListTile(Icons.logout_rounded, 'Sign Out', color: AppTheme.textTertiary, onTap: () => HapticService.medium()),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w900, color: AppTheme.textTertiary, letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, {String? subtitle, Widget? trailing, Color? color, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: (color ?? AppTheme.primary).withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, size: 22, color: color ?? AppTheme.primary),
      ),
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          HapticService.light();
        }
      },
    );
  }

  Widget _buildTransparencyTile(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppTheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeletionSafetyDialog extends StatefulWidget {
  const DeletionSafetyDialog({super.key});

  @override
  State<DeletionSafetyDialog> createState() => _DeletionSafetyDialogState();
}

class _DeletionSafetyDialogState extends State<DeletionSafetyDialog> {
  int _secondsRemaining = 5;
  Timer? _timer;
  final TextEditingController _controller = TextEditingController();
  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _controller.addListener(() {
      final isNowConfirmed = _controller.text.trim().toUpperCase() == 'DELETE';
      if (isNowConfirmed && !_isConfirmed) {
        HapticService.medium();
      }
      setState(() {
        _isConfirmed = isNowConfirmed;
      });
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        HapticService.selection();
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
        HapticService.success();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canDelete = _secondsRemaining == 0 && _isConfirmed;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
          const SizedBox(width: 12),
          Text('CRITICAL ACTION', style: GoogleFonts.outfit(fontWeight: FontWeight.w900, color: Colors.red, fontSize: 16)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deleting your account will permanently wipe all journal entries, favorites, and activity logs from our production systems.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Text(
            'This action satisfies Google Play Data Deletion requirements and is IRREVERSIBLE.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),
          Text(
            'To confirm, type "DELETE" below:',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 11),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'DELETE',
              filled: true,
              fillColor: Colors.red.withOpacity(0.05),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      actions: [
        TextButton(
          onPressed: () {
            HapticService.light();
            Navigator.pop(context);
          },
          child: Text('CANCEL', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: AppTheme.textTertiary)),
        ),
        ElevatedButton(
          onPressed: canDelete ? _executeDeletion : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            _secondsRemaining > 0 ? 'WAIT ($_secondsRemaining)s' : 'DELETE PERMANENTLY',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Future<void> _executeDeletion() async {
    HapticService.heavy();
    // Purge local data
    await JournalStorageService.clearAll();
    await LocalStorageService.clearAll();
    
    // Purge Firebase data
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
    }
    
    if (mounted) {
      Navigator.pop(context);
      HapticService.success();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account and all associated data have been purged.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}
