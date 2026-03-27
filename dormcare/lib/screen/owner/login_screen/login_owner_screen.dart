import 'package:flutter/material.dart';
import 'package:dormcare/theme/app_theme.dart';

class LoginOwnerScreen extends StatefulWidget {
  const LoginOwnerScreen({super.key});

  @override
  State<LoginOwnerScreen> createState() => _LoginOwnerScreenState();
}

class _LoginOwnerScreenState extends State<LoginOwnerScreen> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

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

          // Decorative circles
          _buildDecorativeCircles(),

          // Positioned(
          //   top: screenHeight * 0.4,
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: Color(0xFFF8F9FB),
          //       borderRadius: BorderRadius.vertical(
          //         top: Radius.circular(26),
          //       ),
          //     ),
          //   ),
          // ),

          // Content(Header, Card, Footer)
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

        Positioned(
          top: 240,
          right: 60,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.05),
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
          child: const Icon(Icons.home_outlined, color: AppColors.white, size: 36),
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
            fontWeight: FontWeight.w400,
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

          // Email / Username
          _buildLabel('Email or Username'),
          const SizedBox(height: 8),
          _buildTextField(
            hintText: 'Enter your email or username',
            prefixIcon: Icons.alternate_email_rounded,
          ),

          const SizedBox(height: 16),

          // Password
          _buildLabel('Password'),
          const SizedBox(height: 8),
          _buildTextField(
            hintText: 'Enter your password',
            obscure: _obscurePassword,
            prefixIcon: Icons.lock_outline_rounded,
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

          // Remember me + Forgot
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
                    const SnackBar(
                      content: Text(
                        'This feature is currently under development',
                      ),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 2),
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
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/owner/home',
                (route) => false,
              ),
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
                child: const Center(
                  child: Text(
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
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textTertiary,
          ),
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
    required String hintText,
    bool obscure = false,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextField(
      obscureText: obscure,
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
