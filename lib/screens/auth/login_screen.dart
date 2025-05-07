import 'package:flutter/material.dart';
import 'package:gudangku/pages/main_page.dart';
import '../../widgets/custom_text_field.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ganti Icon jadi Image.asset
                  Image.asset(
                    'lib/images/ab-removebg-preview.png', // Ganti sesuai nama file kamu
                    height: 200, // Atur ukuran logo
                  ),
                  const SizedBox(height: 12),
                  
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    isObscure: true,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Email dan password harus diisi.")),
                          );
                          return;
                        }

                        try {
                          final response = await AuthService.login(email, password);

                          if (response != null && response['token'] != null) {
                            final token = response['token'];
                            print("Login berhasil! Token: $token");

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const MainPage()),
                            );
                          } else {
                            // Log error ke console
                            print('Login gagal: ${response?['message'] ?? 'Tidak ada respons'}');

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response?['message'] ?? 'Login gagal, periksa email dan password')),
                            );
                          }
                        } catch (e) {
                          // Log error exception
                          print('Terjadi error saat login: $e');

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Terjadi kesalahan saat mencoba login')),
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Belum punya akun? "),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text('Daftar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
