import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayush Singh Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                AboutMe(),
                Skills(),
                Projects(),
                Contact(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Create a gradient background
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF1A237E),
        Color(0xFF3949AB),
        Color(0xFF303F9F),
      ],
      stops: [0.0, 0.5, 1.0],
    );

    paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Add animated particles
    final particlePaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 50; i++) {
      final x = (size.width * i / 50 + animationValue * 20) % size.width;
      final y = (size.height * sin(i * 0.1 + animationValue * 2)) % size.height;
      canvas.drawCircle(Offset(x, y), 2, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Ayush Singh',
                  textStyle: TextStyle(
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                ),
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
            ),
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Software Developer',
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TyperAnimatedText(
                  'Quantum Computing Enthusiast',
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TyperAnimatedText(
                  'ML Practitioner',
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
              repeatForever: true,
            ),
          ],
        ),
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ShimmerText(
            text: 'About Me',
            baseColor: Colors.purple,
            highlightColor: Colors.white,
          ),
          SizedBox(height: 20),
          AnimationLimiter(
            child: AnimationConfiguration.synchronized(
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: GlassContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Hello, I am Ayush Singh, a passionate software developer with a keen interest in quantum computing, machine learning, and data science. I am always eager to explore new technologies and implement innovative solutions that can have a positive impact. With a strong foundation in both theoretical and practical aspects of computing, I am currently focused on learning more about quantum algorithms, machine learning frameworks, and developing applications that utilize these technologies. My goal is to contribute to groundbreaking solutions in the tech industry by combining my skills in software development and cutting-edge research.',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
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
}

class Skills extends StatelessWidget {
  final List<Map<String, String>> skills = [
    {'name': 'Python', 'description': 'A versatile and powerful language, widely used for data analysis, machine learning, and automation. Python’s simple syntax and rich ecosystem of libraries like Pandas and NumPy make data manipulation seamless. For machine learning, Scikit-learn, TensorFlow, and Keras are key tools for building intelligent models. It also excels in automation, allowing you to streamline tasks effortlessly with frameworks like Selenium and Automate.'},
    {'name': 'Dart', 'description': 'A modern, fast programming language designed for building mobile, web, and server applications. With Flutter, Dart powers cross-platform mobile app development, enabling developers to create high-performance, beautiful apps from a single codebase. Dart’s strong typing and asynchronous programming features make it an excellent choice for building responsive, scalable applications with ease.'},
    {'name': 'Quantum Computing', 'description': ' A groundbreaking field that applies the principles of quantum mechanics to solve complex computational problems beyond the capability of classical computers. From understanding quantum bits (qubits) to developing quantum algorithms, it offers revolutionary potential for fields like cryptography, optimization, and simulation of quantum systems. A fascinating journey into the future of computing.'},
    {'name': 'Machine Learning', 'description': 'The science of enabling machines to learn from data and improve over time. With tools like TensorFlow, Keras, and Scikit-learn, you can develop models that perform predictive analytics, classification, and regression tasks. Machine learning is the backbone of AI applications, powering intelligent systems that can adapt to new information and make decisions autonomously.'},
    {'name': 'Flutter Development', 'description': 'A powerful open-source framework for building high-quality mobile, web, and desktop applications from a single codebase. Flutter enables cross-platform development, allowing developers to create beautiful, fast, and responsive apps for both Android and iOS. With its rich set of widgets and customizable UI components, Flutter makes it easy to build stunning and native-like user experiences.'},
    {'name': 'Data Science', 'description': 'The art and science of extracting valuable insights from data. Involves data preprocessing, statistical analysis, and visualization to transform raw data into actionable knowledge. Using tools like Pandas, Matplotlib, and Seaborn, data scientists can uncover patterns, make predictions, and communicate findings effectively. It’s a field at the intersection of technology, statistics, and business, crucial for driving data-driven decision-making.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ShimmerText(
            text: 'Skills',
            baseColor: Colors.blue,
            highlightColor: Colors.white,
          ),
          SizedBox(height: 20),
          AnimationLimiter(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: SkillCard(
                        name: skills[index]['name']!,
                        description: skills[index]['description']!,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String name;
  final String description;

  SkillCard({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 24, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class Projects extends StatelessWidget {
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Quantum Computing Model',
      'description': 'Developed a simulation model to showcase how quantum algorithms can be applied to real-world problems.',
      'image': 'assets/images/img_1.png',
    },
    {
      'title': 'Machine Learning Web App',
      'description': 'Built a web application using machine learning models to make predictions based on user input.',
      'image': 'assets/images/img.png',
    },
    {
      'title': 'Flutter Mobile App',
      'description': 'Developed a mobile application using Flutter featuring a dynamic interface with various UI components.',
      'image': 'assets/images/Screenshot 2024-12-08 185932.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ShimmerText(
            text: 'Projects',
            baseColor: Colors.green,
            highlightColor: Colors.white,
          ),
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: projects.map((project) {
              return Builder(
                builder: (BuildContext context) {
                  return GlassContainer(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              project['image'],
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project['title'],
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  project['description'],
                                  style: TextStyle(fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ShimmerText(
            text: 'Contact Me',
            baseColor: Colors.orange,
            highlightColor: Colors.white,
          ),
          SizedBox(height: 20),
          GlassContainer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'I am always open to new opportunities, collaborations, or discussions related to technology. Feel free to reach out to me through the following channels:',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContactButton(
                icon: Icons.email,
                text: 'Email',
                onPressed: () => _launchURL('mailto:ayush.personal96@gmail.com'),
              ),
              SizedBox(width: 20),
              ContactButton(
                icon: Icons.link,
                text: 'LinkedIn',
                onPressed: () => _launchURL('https://linkedin.com/in/ayush-singh-074932293'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ContactButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  ContactButton({required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;

  GlassContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final String text;
  final Color baseColor;
  final Color highlightColor;

  ShimmerText({required this.text, required this.baseColor, required this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [baseColor, highlightColor, baseColor],
        stops: [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
