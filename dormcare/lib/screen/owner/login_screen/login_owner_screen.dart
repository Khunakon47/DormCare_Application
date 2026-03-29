import 'package:flutter/material.dart';
import 'package:dormcare/theme/app_theme.dart';

import 'package:dormcare/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:dormcare/providers/user_provider.dart';

class LoginOwnerScreen extends StatefulWidget {
  const LoginOwnerScreen({super.key});

  @override
  State<LoginOwnerScreen> createState() => _LoginOwnerScreenState();
}

class _LoginOwnerScreenState extends State<LoginOwnerScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _authService = AuthService();

  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter email and password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userData = await _authService.login(email, password);

      if (!mounted) return;

      // ตรวจสอบ role — ต้องเป็น owner เท่านั้น
      if (userData?['role'] != 'owner') {
        _showError(
          'This account is not an owner account.\nPlease use Tenant Login.',
        );
        setState(() => _isLoading = false);
        return;
      }

      context.read<UserProvider>().setUser(userData!);

      // Login สำเร็จ → navigate ไป home
      Navigator.pushNamedAndRemoveUntil(context, '/owner/home', (r) => false);
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Top gradient background
          Container(
            height: screenHeight * 0.42,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.ownerPrimary, AppColors.ownerSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          _buildDecorativeCircles(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.07),
                  _buildLogoSection(),
                  SizedBox(height: screenHeight * 0.05),
                  _buildLoginCard(),
                  const SizedBox(height: 24),
                  _buildFooter(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircles() {
    return Stack(
      children: [
        Positioned(
          top: -60,
          right: -40,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.06),
            ),
          ),
        ),
        Positioned(
          top: 250,
          left: 10,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.04),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.white.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.home_outlined,
            color: AppColors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'DormCare',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Manage your dormitory with ease',
          style: TextStyle(
            color: AppColors.white.withValues(alpha: 0.75),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.ownerPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.manage_accounts_outlined,
                  size: 18,
                  color: AppColors.ownerPrimary,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Owner Login',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Email
          _buildLabel('Email'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _emailCtrl,
            hintText: 'Enter your email',
            prefixIcon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          // Password
          _buildLabel('Password'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _passwordCtrl,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline_rounded,
            obscure: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: AppColors.textTertiary,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _rememberMe = !_rememberMe),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _rememberMe
                            ? AppColors.ownerPrimary
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: _rememberMe
                              ? AppColors.ownerPrimary
                              : AppColors.textDisabled,
                        ),
                      ),
                      child: _rememberMe
                          ? const Icon(
                              Icons.check,
                              size: 13,
                              color: AppColors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'This feature is currently under development',
                      ),
                      backgroundColor: AppColors.ownerPrimary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ownerPrimary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // Sign In button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: _isLoading ? null : _login,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.ownerPrimary, AppColors.ownerSecondary],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.ownerPrimary.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          'Need an account?',
          style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
        ),
        const SizedBox(height: 4),
        Text(
          'Contact system support for admin registration.',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textTertiary,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Divider(color: AppColors.border.withValues(alpha: 0.2), thickness: 1),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          icon: const Icon(
            Icons.person_outline,
            color: AppColors.ownerPrimary,
            size: 18,
          ),
          label: const Text(
            'Login as Tenant',
            style: TextStyle(
              color: AppColors.ownerPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),
        prefixIcon: Icon(prefixIcon, size: 18, color: AppColors.textTertiary),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.ownerPrimary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
