import 'package:flutter/material.dart';
import 'package:warm_heart_time_app/core/constants/app_colors.dart';
import 'package:warm_heart_time_app/core/constants/app_text_styles.dart';
import 'package:warm_heart_time_app/presentation/screens/main_record_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _employeeIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // TODO: 實際登入邏輯
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登入中... (UI展示)')),
      );
      // 模擬登入成功
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainRecordScreen()), // <-- 改成新的主頁面
        );
    }
  }

  @override
  void dispose() {
    _employeeIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset('assets/images/app_logo.png', height: 100),
                  const SizedBox(height: 16),
                  Text(
                    '歡迎回來，暖心夥伴',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headline2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '請登入您的帳號',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle1,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _employeeIdController,
                    decoration: const InputDecoration(
                      labelText: '照服員編號 / 手機號碼',
                      prefixIcon: Icon(Icons.person_outline, color: AppColors.iconColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入您的編號或手機號碼';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: '密碼',
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.iconColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.iconColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入您的密碼';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: 忘記密碼邏輯
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('忘記密碼功能待實現')),
                        );
                      },
                      child: Text('忘記密碼？', style: AppTextStyles.bodyText2.copyWith(color: AppColors.primaryDark)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('登入'),
                  ),
                  // 可選：其他登入方式，例如機構代碼
                  // SizedBox(height: 20),
                  // TextButton(
                  //   onPressed: () {
                  //     // TODO: 切換到機構代碼登入
                  //   },
                  //   child: Text('使用機構代碼登入', style: AppTextStyles.bodyText2.copyWith(color: AppColors.primaryDark)),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}