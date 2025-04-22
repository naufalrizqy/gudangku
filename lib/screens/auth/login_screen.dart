import 'package:flutter/material.dart';
import 'package:gudangku/pages/main_page.dart';
import '../../widgets/custom_text_field.dart';

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
                  const Icon(Icons.inventory_2_rounded, size: 72, color: Colors.indigo),
                  const SizedBox(height: 12),
                  const Text(
                    'Gudangku',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
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
                      onPressed: () {
                        // TODO: arahkan ke halaman reset password
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return MainPage();
                        })  );
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
                        // TODO: arahkan ke halaman reset password
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
                          // TODO: arahkan ke halaman register
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
