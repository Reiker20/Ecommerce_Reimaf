import 'package:flutter_ecommerce/common/my_colors.dart';
import 'package:flutter_ecommerce/common/my_styles.dart';
import 'package:flutter_ecommerce/providers/auth_provider.dart';
import 'package:flutter_ecommerce/view/sign_in/sign_in.dart';
import 'package:flutter_ecommerce/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: MyColors.alertColor,
            content: Text(
              authProvider.errorMessage != ''
                  ? authProvider.errorMessage
                  : 'Pendaftaran gagal dilakukan',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Image.asset('assets/images/logo/main-logo.png',),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign Up", style: MyStyle.pageTitle),
                ],
              ),
              const SizedBox(height: 44),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "Nama Anda",
                  prefixIcon: const Icon(Icons.person),
                  hintStyle: MyStyle.regularText,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "Username",
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  hintStyle: MyStyle.regularText,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "E-mail",
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  hintStyle: MyStyle.regularText,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: "Password",
                  hintStyle: MyStyle.regularText,
                ),
              ),
             SizedBox(height: 50,),
              isLoading
                  ? LoadingButton()
                  : ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 12)),
                        backgroundColor:
                            MaterialStateProperty.all(MyColors.primaryOrange),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      onPressed: () {
                        handleSignUp();
                      },
                      child: Text(
                        'Sign Up',
                        style: MyStyle.pageTitle.copyWith(color: Colors.white),
                      ),
                    ),
              const SizedBox(height: 11),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: MyStyle.regularText),
                  InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/sign-in');
                    },
                    child: Text("Sign In",
                        style: MyStyle.regularText
                            .copyWith(color: MyColors.primaryOrange)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
