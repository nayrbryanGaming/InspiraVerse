import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/haptic_service.dart';

class PrivacyHubPage extends StatelessWidget {
  const PrivacyHubPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.auraGradient,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Icon(Icons.shield_moon_rounded, size: 64, color: Colors.white),
                      const SizedBox(height: 16),
                      Text(
                        'Your Mind is Private',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Data Sovereignty'),
                  _buildInfoCard(
                    Icons.lock_person_rounded,
                    'Zero Tracking Policy',
                    'We do not sell, rent, or trade your personal data. Your psychological journey is encrypted and yours alone.',
                  ),
                  _buildInfoCard(
                    Icons.storage_rounded,
                    'Local-First Sovereignty',
                    'Your journal reflections are stored securely on your device. Cloud sync is optional and end-to-end encrypted.',
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Compliance & Safety'),
                  _buildInfoCard(
                    Icons.gavel_rounded,
                    'Google Play Certified',
                    'InspiraVerse adheres to the latest Global Data Safety standards, including full transparent data deletion rights.',
                  ),
                  _buildInfoCard(
                    Icons.delete_sweep_rounded,
                    'Immediate Purge Trigger',
                    'When you request deletion, we initiate an immediate server-side process to wipe all document clusters associated with your ID.',
                  ),
                  const SizedBox(height: 40),
                  _buildSectionHeader('Mandatory Legal Transparency'),
                  _buildLegalAction(
                    Icons.policy_rounded,
                    'Review Privacy Policy',
                    onTap: () => _launchUrl('https://inspiraverse.app/legal/privacy'),
                  ),
                  _buildLegalAction(
                    Icons.description_rounded,
                    'Terms of Service',
                    onTap: () => _launchUrl('https://inspiraverse.app/legal/terms'),
                  ),
                  const SizedBox(height: 40),
                  const Divider(height: 1),
                  const SizedBox(height: 40),
                  _buildDeleteSection(context),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: AppTheme.textTertiary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primary.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: AppTheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalAction(IconData icon, String label, {required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppTheme.primary.withOpacity(0.1)),
        ),
        tileColor: Colors.white,
        leading: Icon(icon, color: AppTheme.primary),
        title: Text(
          label,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        trailing: const Icon(Icons.open_in_new_rounded, size: 18, color: AppTheme.textTertiary),
      ),
    );
  }

  Widget _buildDeleteSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.red.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sensitive Controls',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w900, color: Colors.red, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Text(
            'Permanent account deletion will wipe your entire digital footprint on InspiraVerse. This cannot be undone.',
            style: GoogleFonts.outfit(fontSize: 13, color: Colors.red.withOpacity(0.7), height: 1.5),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                HapticService.heavy();
                Navigator.pop(context); // Go back to profile to trigger deletion
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'REQUEST ACCOUNT DELETION',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
