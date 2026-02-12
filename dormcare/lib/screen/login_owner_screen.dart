import 'package:flutter/material.dart';

class LoginOwnerScreen  extends StatelessWidget {
  const LoginOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== TOP GRADIENT HEADER =====
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA34CF3), Color(0xFF4F45E2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFAB61F0),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.home_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "DormCare",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // ===== LOGIN SECTION =====
            Transform.translate(
              offset: const Offset(0, -60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // ⭐ แก้หลักตรงนี้
                  children: [
                    // ===== LOGIN CARD =====
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Owner Login",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Manage your dormitory.",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),

                          const SizedBox(height: 22),

                          // ===== Room Number =====
                          const Text(
                            "Email or Username",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter an email or username",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF7F8FA),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3F7BF6),
                                  width: 1.4,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ===== Password =====
                          const Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF7F8FA),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1.2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3F7BF6),
                                  width: 1.4,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // ===== Remember + Forgot =====
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (v) {}),
                              const Text(
                                "Remember me",
                                style: TextStyle(fontSize: 13),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFB475F8),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // ===== Sign In Button =====
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFA555F6),
                                    Color(0xFF4F46E5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ===== Text ใต้การ์ด =====
                    const Text(
                      "Contact system support for admin registration.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // ===== Divider =====
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),

                    const SizedBox(height: 10),

                    // ===== Login as Owner =====
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person_outline,
                        color: Color(0xFFA855F7), size: 22,
                      ),
                      label: const Text(
                        "Login as Tenant",
                        style: TextStyle(
                          color: Color(0xFFA855F7),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
