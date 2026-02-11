import 'package:flutter/material.dart';

class LoginTenantScreen extends StatefulWidget {
  const LoginTenantScreen({super.key, required this.onLoginSuccess});

  final VoidCallback onLoginSuccess;

  @override
  State<LoginTenantScreen> createState() => _LoginTenantScreenState();
}

class _LoginTenantScreenState extends State<LoginTenantScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    // ใช้ MediaQuery เพื่อคำนวณความสูงจอ สำหรับการจัดตำแหน่ง
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF0F2F5)),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // ส่วนพื้นหลังสีฟ้า (HEADER BACKGROUND)
          Container(
            height: screenHeight * 0.45,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3F7BF6), Color(0xFF2F66F3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ส่วนเนื้อหา (CONTENT)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // ดัน Content ลงมาให้อยู่กึ่งกลางมากขึ้น (ปรับค่านี้เพื่อ เลื่อนขึ้น-ลง ทั้งหมด)
                SizedBox(height: screenHeight * 0.15),

                // ===== LOGO SECTION =====
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5B95FA),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "DormCare",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ===== LOGIN CARD SECTION =====
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tenant Login",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Sign in to manage your room with ease",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                      const SizedBox(height: 24),

                      // ===== Room Number Field =====
                      const Text(
                        "Room Number",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your room number",
                          hintStyle: TextStyle(
                            color: Colors.grey.withValues(alpha: 0.6),
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF3F7BF6),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ===== Password Field =====
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(
                            color: Colors.grey.withValues(alpha: 0.6),
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF3F7BF6),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ===== Remember & Forgot =====
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: const Color(0xFF3F7BF6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (v) {
                                setState(() {
                                  _rememberMe = v!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Remember me",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "This feature is currently under development",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3F7BF6),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ===== Sign In Button =====
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3F7BF6), Color(0xFF5A4CF3)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF3F7BF6,
                              ).withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            widget.onLoginSuccess();
                          },
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
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ===== Footer Text =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Please Contact your dormitory management if you don't have an account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withValues(alpha: 0.8),
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ===== Divider =====
                Divider(
                  color: Colors.grey.withValues(alpha: 0.3),
                  thickness: 1,
                ),

                const SizedBox(height: 5),

                // ===== Login as Owner =====
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF367BF3),
                    size: 20,
                  ),
                  label: const Text(
                    "Login as Owner",
                    style: TextStyle(
                      color: Color(0xFF367BF3),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
