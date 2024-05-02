import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    const emailPattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

    const numbersPattern = r"^\d+$";

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Icon(Icons.home),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            image: DecorationImage(
              image: AssetImage("images/home_artwork.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(36),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "can't be blank";
                    } else if (!RegExp(emailPattern).hasMatch(value)) {
                      return "invalid email";
                    }

                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white60,
                  decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 26),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.length <= 6) {
                      return "must be at least 6 characters";
                    }
                    return null;
                  },
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white60,
                  decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "can't be blank";
                          }

                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white60,
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(color: Colors.red),
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white60,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white60,
                                width: 1.0,
                              ),
                            ),
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 28),
                    Flexible(
                      child: TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "can't be blank";
                          }

                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white60,
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(color: Colors.red),
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white60,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white60,
                                width: 1.0,
                              ),
                            ),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "can't be blank";
                    } else if (!RegExp(numbersPattern).hasMatch(value) ||
                        value.length != 13) {
                      return "invalid CNP";
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white60,
                  decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      labelText: 'CNP',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 26),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "can't be blank";
                    } else if (!RegExp(numbersPattern).hasMatch(value)) {
                      return "invalid format";
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white60,
                  decoration: const InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1.0,
                        ),
                      ),
                      labelText: 'Doctor Badge Number',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 64),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 7, 104, 250),
                      elevation: 2,
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Process data.
                      }
                      ;
                    },
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Sign In.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
