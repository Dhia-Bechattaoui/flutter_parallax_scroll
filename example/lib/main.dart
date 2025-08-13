import 'package:flutter/material.dart';
import 'package:flutter_parallax_scroll/flutter_parallax_scroll.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Parallax Scroll Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ParallaxDemoPage(),
    );
  }
}

class ParallaxDemoPage extends StatefulWidget {
  const ParallaxDemoPage({super.key});

  @override
  State<ParallaxDemoPage> createState() => _ParallaxDemoPageState();
}

class _ParallaxDemoPageState extends State<ParallaxDemoPage> {
  late ParallaxScrollController _controller;
  double _speed = 0.5;
  ParallaxDirection _direction = ParallaxDirection.forward;

  @override
  void initState() {
    super.initState();
    _controller = ParallaxScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parallax Scroll Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: ParallaxScrollView(
        controller: _controller,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section with Parallax Background
              _buildHeroSection(),

              // Controls Section
              _buildControlsSection(),

              // Multiple Parallax Layers
              _buildMultipleLayersSection(),

              // Different Directions Demo
              _buildDirectionsDemo(),

              // Content Sections
              _buildContentSections(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 400,
      child: Stack(
        children: [
          // Parallax background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade300,
                    Colors.purple.shade300,
                    Colors.pink.shade300,
                  ],
                ),
              ),
            ).asParallaxItem(
              controller: _controller,
              config: ParallaxConfig(
                speed: 0.3,
                direction: ParallaxDirection.reverse,
              ),
            ),
          ),

          // Content
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Flutter Parallax Scroll',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ).asParallaxItem(
                    controller: _controller,
                    config: ParallaxConfig(
                      speed: 0.1,
                      direction: ParallaxDirection.forward,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Beautiful scrolling effects with customizable speed and direction',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ).asParallaxItem(
                    controller: _controller,
                    config: ParallaxConfig(
                      speed: 0.2,
                      direction: ParallaxDirection.forward,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlsSection() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Controls',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // Speed Slider
          Text('Speed: ${_speed.toStringAsFixed(1)}'),
          Slider(
            value: _speed,
            min: 0.0,
            max: 2.0,
            divisions: 20,
            onChanged: (value) {
              setState(() {
                _speed = value;
                _controller.updateConfig(
                  ParallaxConfig(speed: _speed, direction: _direction),
                );
              });
            },
          ),

          // Direction Dropdown
          Text('Direction:'),
          DropdownButton<ParallaxDirection>(
            value: _direction,
            isExpanded: true,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _direction = value;
                  _controller.updateConfig(
                    ParallaxConfig(speed: _speed, direction: _direction),
                  );
                });
              }
            },
            items: ParallaxDirection.values.map((direction) {
              return DropdownMenuItem(
                value: direction,
                child: Text(direction.name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleLayersSection() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          // Background layer (slowest)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.red.shade200, Colors.red.shade400],
                ),
              ),
            ).asParallaxItem(
              controller: _controller,
              config: ParallaxConfig(speed: 0.2),
            ),
          ),

          // Middle layer (medium speed)
          Positioned(
            left: 50,
            right: 50,
            top: 50,
            bottom: 50,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.green.shade200, Colors.green.shade400],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ).asParallaxItem(
              controller: _controller,
              config: ParallaxConfig(speed: 0.5),
            ),
          ),

          // Foreground layer (fastest)
          Positioned(
            left: 100,
            right: 100,
            top: 100,
            bottom: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.blue.shade200, Colors.blue.shade400],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Multiple Layers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ).asParallaxItem(
              controller: _controller,
              config: ParallaxConfig(speed: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionsDemo() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Direction Examples',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // Forward direction
          Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade300, Colors.orange.shade500],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Forward Direction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ).asParallaxItem(
            controller: _controller,
            config: ParallaxConfig(
              speed: 0.3,
              direction: ParallaxDirection.forward,
            ),
          ),

          // Reverse direction
          Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade300, Colors.purple.shade500],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Reverse Direction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ).asParallaxItem(
            controller: _controller,
            config: ParallaxConfig(
              speed: 0.3,
              direction: ParallaxDirection.reverse,
            ),
          ),

          // Horizontal direction
          Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade300, Colors.teal.shade500],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Horizontal Direction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ).asParallaxItem(
            controller: _controller,
            config: ParallaxConfig(
              speed: 0.3,
              direction: ParallaxDirection.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSections() {
    return Column(
      children: List.generate(5, (index) {
        return Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.primaries[index % Colors.primaries.length].shade300,
                Colors.primaries[index % Colors.primaries.length].shade500,
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Content Section ${index + 1}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ).asParallaxItem(
          controller: _controller,
          config: ParallaxConfig(
            speed: 0.1 + (index * 0.1),
            direction: ParallaxDirection.forward,
          ),
        );
      }),
    );
  }
}
