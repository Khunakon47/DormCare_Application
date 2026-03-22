import 'package:flutter/material.dart';

class LoginTenantScreen extends StatefulWidget {
  const LoginTenantScreen({super.key});

  @override
  State<LoginTenantScreen> createState() => _LoginTenantScreenState();
}

class _LoginTenantScreenState extends State<LoginTenantScreen> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Stack(
        children: [
          // Top gradient background
          Container(
            height: screenHeight * 0.42,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF367BF3), Color(0xFF2457D9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Decorative circles
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.07),

                  // Logo + app name
                  _buildLogoSection(),

                  SizedBox(height: screenHeight * 0.05),

                  // Login card
                  _buildLoginCard(),

                  const SizedBox(height: 24),

                  // Footer
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

  // ─── Sections ─────────────────────────────────────────────────────────────

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: const Icon(Icons.home_outlined, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 14),
        const Text(
          'DormCare',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Manage your room with ease',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF367BF3).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 18,
                  color: Color(0xFF367BF3),
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tenant Login',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0D1B2A),
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'Sign in to your account',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9AA5B4)),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Room Number
          _buildLabel('Room Number'),
          const SizedBox(height: 8),
          _buildTextField(
            hintText: 'Enter your room number',
            prefixIcon: Icons.meeting_room_outlined,
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
                color: Colors.grey.shade400,
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
                            ? const Color(0xFF367BF3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: _rememberMe
                              ? const Color(0xFF367BF3)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: _rememberMe
                          ? const Icon(
                              Icons.check,
                              size: 13,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
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
                    color: Color(0xFF367BF3),
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
                '/tenant/home',
                (route) => false,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF367BF3), Color(0xFF2457D9)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF367BF3).withValues(alpha: 0.35),
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
                      color: Colors.white,
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
          "Don't have an account?",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Contact your dormitory management.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.withValues(alpha: 0.6),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.grey.withValues(alpha: 0.2), thickness: 1),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/login/owner',
            (route) => false,
          ),
          icon: const Icon(
            Icons.manage_accounts_outlined,
            color: Color(0xFF367BF3),
            size: 18,
          ),
          label: const Text(
            'Login as Owner',
            style: TextStyle(
              color: Color(0xFF367BF3),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: Color(0xFF0D1B2A),
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
      style: const TextStyle(fontSize: 14, color: Color(0xFF0D1B2A)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: Icon(prefixIcon, size: 18, color: Colors.grey.shade400),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF7F8FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF367BF3), width: 1.5),
        ),
      ),
    );
  }
}
