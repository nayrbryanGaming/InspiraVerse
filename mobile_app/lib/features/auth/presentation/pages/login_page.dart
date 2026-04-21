import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/haptic_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isGuestLoading = false;

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      HapticService.medium();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Authentication failed');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInAsGuest() async {
    setState(() => _isGuestLoading = true);
    try {
      HapticService.heavy();
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      _showError('Guest access failed. Check connection.');
    } finally {
      if (mounted) setState(() => _isGuestLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Background Aesthetic
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ).animate().scale(duration: 2.seconds).fadeIn(),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Welcome back',
                    style: GoogleFonts.outfit(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textPrimary,
                      letterSpacing: -1,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2),
                  const SizedBox(height: 8),
                  Text(
                    'Your journey to mental resilience continues here.',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 60),
                  
                  // Login Form
                  _buildTextField(_emailController, 'Email Address', Icons.email_outlined),
                  const SizedBox(height: 20),
                  _buildTextField(_passwordController, 'Password', Icons.lock_outline_rounded, isObscure: true),
                  const SizedBox(height: 32),
                  
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      shadowColor: AppTheme.primary.withOpacity(0.4),
                    ),
                    child: _isLoading 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text('Sign In', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white)),
                  ),
                  const SizedBox(height: 24),
                  
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('OR', style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textTertiary, fontWeight: FontWeight.bold)),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  OutlinedButton(
                    onPressed: _isGuestLoading ? null : _signInAsGuest,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      side: BorderSide(color: AppTheme.primary.withOpacity(0.2)),
                    ),
                    child: _isGuestLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: AppTheme.primary, strokeWidth: 2))
                      : Text('Continue as Guest', style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 16, color: AppTheme.primary)),
                  ),
                  const SizedBox(height: 48),
                  
                  // Legal Disclosure
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'By signing in, you agree to our',
                          style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textTertiary),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLegalLink('Terms of Service', 'https://inspiraverse.app/legal/terms'),
                            Text('  •  ', style: TextStyle(color: AppTheme.textTertiary.withOpacity(0.5))),
                            _buildLegalLink('Privacy Policy', 'https://inspiraverse.app/legal/privacy'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLink(String text, String url) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 12,
          color: AppTheme.primary,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isObscure = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppTheme.primary.withOpacity(0.5)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
