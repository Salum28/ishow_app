import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:animated_login/custom_input.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Variables
  final Image _image = Image.asset('assets/images/fundo.png');
  late final AnimationController _controller;
  late Animation<double> _blurAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _sizeAnimation;

  // Methods
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    _blurAnimation = Tween<double>(
      begin: 5,
      end: 0
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _fadeAnimation = Tween<double>(
        begin: 0,
        end: 1
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint));

    _sizeAnimation = Tween<double>(
        begin: 0,
        end: 500
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 8;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _blurAnimation,
                builder: (context, widget) {
                  return Container(
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: _image.image,
                              fit: BoxFit.fill
                          )
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: _blurAnimation.value,
                            sigmaY: _blurAnimation.value
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                left: 10,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Image.asset('assets/images/detalhe1.png')
                                )
                            ),
                            Positioned(
                                left: 50,
                                child: FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Image.asset('assets/images/detalhe2.png')
                                )
                            )
                          ],
                        ),
                      )
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _sizeAnimation,
                      builder: (context, widget) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          width: _sizeAnimation.value,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200]!,
                                  blurRadius: 15,
                                  spreadRadius: 4
                              )
                            ]
                          ),
                          child: const Column(
                            children: [
                              CustomInput(hint: 'E-mail'),
                              CustomInput(
                                  hint: 'Senha',
                                  obscure: true,
                                  icon: Icon(Icons.lock)
                              )
                            ],
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _sizeAnimation,
                      builder: (context, widget) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: _sizeAnimation.value,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(255, 100, 127, 1),
                                  Color.fromRGBO(255, 123, 145, 1)
                                ]
                              )
                            ),
                            child: const Center(
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 100, 127, 1),
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  ],
                ),
              )
            ]
          )
        ),
      )
    );
  }
}
