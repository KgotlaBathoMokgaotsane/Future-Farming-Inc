import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:app/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
   const LoginPage ({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
   void signUserIn() async {

     //show loading circle
     showDialog(
       context: context,
       builder: (context) {
       return const Center(
         child: CircularProgressIndicator(),
        );
       },
     );

     //try sign in
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //pop the loading circle
        Navigator.pop(context);
      }on FirebaseAuthException catch (e) {
        //pop the loading circle
        Navigator.pop(context);
        //show error message
        showErrorMessage(e.code);
      }

   }

   //error message to user pop up
  void showErrorMessage(String message) {
     showDialog(
       context: context,
       builder: (context) {
       return AlertDialog(
         backgroundColor: Colors.deepPurple,
         title:Center(
         child: Text(
             message,
           style: const TextStyle(color: Colors.white),
          ),
         ),
       );
      },
     );
  }

  //wrong password message pop up
  /*void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
       return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }*/

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //stops the rendering error when the keyboard pops up
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
            const SizedBox(height: 50),

              // logo
             const Icon(
                Icons.lock,
                size: 100,
              ),

             const SizedBox(height: 30),

              // welcome back
              Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
               ),
              ),

              const SizedBox(height: 25),

              //email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),


              const SizedBox(height: 25),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //sign in button
              MyButton(
                text: 'Sign in',
                onTap: signUserIn,
              ),

              const SizedBox(height: 25),

              // or continue with
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // google + apple sign in buttons

              // expanded stops the rendering error
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png'),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              //not a member? register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                      'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
        ),
      ),
    ) ;
  }
}