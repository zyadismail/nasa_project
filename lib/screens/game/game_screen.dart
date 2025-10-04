import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolarFlare {
  final String flareClass;
  final double intensity;
  final String impact;
  final int damage;

  SolarFlare({
    required this.flareClass,
    required this.intensity,
    required this.impact,
    required this.damage,
  });
}

class DefenseStrategy {
  final String id;
  final String name;
  final IconData icon;
  final int cost;
  final String protects;

  DefenseStrategy({
    required this.id,
    required this.name,
    required this.icon,
    required this.cost,
    required this.protects,
  });
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {
  String gameState = 'welcome'; // welcome, playing, fact, gameover
  String playerName = '';
  int score = 15;
  int phase = 0;
  double earthHealth = 100;
  double powerGrid = 100;
  double satellites = 100;
  double communications = 100;
  int countdown = 3;
  String message = '';
  bool showStats = false;
  String currentFact = '';
  String errorMessage = ''; // New: For showing API errors

  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  List<SolarFlare> solarFlares = [];
  final List<String> educationalFacts = [
    '☀ The Sun is a huge ball of hot plasma, and solar flares are giant explosions on its surface!',
    '🛰 Solar flares can disrupt satellites, causing problems with GPS and TV signals.',
    '⚡ Strong flares might cause power outages by affecting electrical grids on Earth.',
    '📡 Communications like radio and phone signals can be interrupted during solar storms.',
    '🌍 NASA and scientists monitor the Sun 24/7 to warn us about solar flares.',
    '🌞 The Sun\'s magnetic field twists and snaps, releasing energy as flares.',
    '💥 X-class flares are the strongest and can cause global blackouts if directed at Earth.',
    '🕒 Solar flares travel at the speed of light, reaching Earth in about 8 minutes.',
    '🌈 Auroras (Northern Lights) are sometimes caused by particles from solar flares.',
    '🔭 The GOES satellites measure X-rays from flares to classify them as B, C, M, or X.',
  ];

  final List<DefenseStrategy> defenseStrategies = [
    DefenseStrategy(
      id: 'satellite',
      name: '🛡 Protect Satellites',
      icon: Icons.shield,
      cost: 10,
      protects: 'satellites',
    ),
    DefenseStrategy(
      id: 'power',
      name: '⚡ Protect Power Grid',
      icon: Icons.flash_on,
      cost: 15,
      protects: 'powerGrid',
    ),
    DefenseStrategy(
      id: 'comms',
      name: '📡 Boost Communications',
      icon: Icons.signal_cellular_alt,
      cost: 8,
      protects: 'communications',
    ),
    DefenseStrategy(
      id: 'full',
      name: '🎯 Full Defense',
      icon: Icons.security,
      cost: 20,
      protects: 'all',
    ),
  ];

  @override
  void initState() {
    super.initState();
    fetchSolarFlares(); // Fetch real-time data

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotateController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));
  }

  Future<void> fetchSolarFlares() async {
    try {
      final response = await http
          .get(
            Uri.parse(
              'https://services.swpc.noaa.gov/json/goes/primary/xray-flares-7-day.json',
            ),
          )
          .timeout(
            Duration(seconds: 10),
            onTimeout: () {
              // Handle timeout
              return http.Response('Timeout', 408);
            },
          );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<SolarFlare> fetchedFlares = [];
        for (var item in data) {
          String flareClass = item['max_class'] ?? 'C1.0';
          double intensity = double.tryParse(flareClass.substring(1)) ?? 1.0;
          String impact = getImpact(flareClass[0]);
          int damage = getDamage(flareClass[0], intensity);
          fetchedFlares.add(
            SolarFlare(
              flareClass: flareClass,
              intensity: intensity,
              impact: impact,
              damage: damage,
            ),
          );
        }
        // Take the last 5 flares or shuffle for variety
        fetchedFlares = fetchedFlares.reversed.take(5).toList();
        if (fetchedFlares.isEmpty) {
          fetchedFlares = _getDefaultFlares(); // Fallback
        }
        setState(() {
          solarFlares = fetchedFlares;
          errorMessage = '';
        });
      } else {
        setState(() {
          solarFlares = _getDefaultFlares();
          errorMessage = 'Failed to load real-time data. Using default flares.';
        });
      }
    } catch (e) {
      setState(() {
        solarFlares = _getDefaultFlares();
        errorMessage = 'Error loading data: $e. Using default flares.';
      });
    }
  }

  List<SolarFlare> _getDefaultFlares() {
    return [
      SolarFlare(
        flareClass: 'C1.5',
        intensity: 1.5,
        impact: 'Minor disruptions expected',
        damage: 5,
      ),
      SolarFlare(
        flareClass: 'M2.1',
        intensity: 2.1,
        impact: 'Possible power grid fluctuations!',
        damage: 15,
      ),
      SolarFlare(
        flareClass: 'X1.3',
        intensity: 1.3,
        impact: 'Critical infrastructure at risk!',
        damage: 30,
      ),
      SolarFlare(
        flareClass: 'B3.2',
        intensity: 3.2,
        impact: 'Minimal impact expected',
        damage: 3,
      ),
      SolarFlare(
        flareClass: 'M5.5',
        intensity: 5.5,
        impact: 'Severe satellite interference!',
        damage: 20,
      ),
    ];
  }

  String getImpact(String classLetter) {
    switch (classLetter) {
      case 'B':
        return 'Minimal impact expected';
      case 'C':
        return 'Minor disruptions expected';
      case 'M':
        return 'Possible power grid fluctuations!';
      case 'X':
        return 'Critical infrastructure at risk!';
      default:
        return 'Unknown impact';
    }
  }

  int getDamage(String classLetter, double intensity) {
    switch (classLetter) {
      case 'B':
        return 3;
      case 'C':
        return (5 + intensity).toInt();
      case 'M':
        return (15 + intensity * 2).toInt();
      case 'X':
        return (30 + intensity * 3).toInt();
      default:
        return 10;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          gameState = 'playing';
        });
      }
    });
  }

  void calculateEarthHealth() {
    setState(() {
      earthHealth = (powerGrid + satellites + communications) / 3;
    });
  }

  void handleDefense(DefenseStrategy strategy) {
    if (score < strategy.cost) {
      setState(() {
        message = '⚠ Not enough points!';
      });
      Timer(Duration(seconds: 2), () {
        setState(() {
          message = '';
        });
      });
      return;
    }

    int newScore = score - strategy.cost;
    final flare = solarFlares[phase];
    final damage = flare.damage.toDouble();

    // Apply damage first
    double tempPowerGrid = powerGrid - damage;
    double tempSatellites = satellites - damage;
    double tempCommunications = communications - damage;

    setState(() {
      if (strategy.protects == 'all') {
        // Full protection: minimal damage and boost
        powerGrid = min(100, (powerGrid - damage * 0.2) + 10);
        satellites = min(100, (satellites - damage * 0.2) + 10);
        communications = min(100, (communications - damage * 0.2) + 10);
        newScore += 25;
        message = '✅ Successful defense! Full Earth protection!';
      } else if (strategy.protects == 'satellites') {
        satellites = max(
          0,
          tempSatellites + damage * 0.7,
        ); // Reduce damage by 70%
        powerGrid = max(0, tempPowerGrid);
        communications = max(0, tempCommunications);
        newScore += 15;
        message = '🛡 Satellites protected!';
      } else if (strategy.protects == 'powerGrid') {
        powerGrid = max(0, tempPowerGrid + damage * 0.7);
        satellites = max(0, tempSatellites);
        communications = max(0, tempCommunications);
        newScore += 20;
        message = '⚡ Power grid protected!';
      } else if (strategy.protects == 'communications') {
        communications = max(0, tempCommunications + damage * 0.7);
        powerGrid = max(0, tempPowerGrid);
        satellites = max(0, tempSatellites);
        newScore += 12;
        message = '📡 Communications boosted!';
      }

      score = newScore;
      calculateEarthHealth();
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        message = '';
        if (earthHealth <= 0) {
          gameState = 'gameover';
        } else {
          // Show fact before next phase
          currentFact =
              educationalFacts[Random().nextInt(educationalFacts.length)];
          gameState = 'fact';
        }
      });
    });
  }

  void proceedToNextPhase() {
    setState(() {
      phase++;
      if (phase >= solarFlares.length) {
        gameState = 'gameover';
      } else {
        gameState = 'playing';
      }
    });
  }

  String getRank() {
    if (score >= 80) return '🌟 Solar Defender Master';
    if (score >= 50) return '🎖 Space Commander';
    if (score >= 25) return '🚀 Space Cadet';
    return '⭐ Space Beginner';
  }

  Color getHealthColor(double value) {
    if (value >= 75) return Colors.green;
    if (value >= 50) return Colors.yellow;
    if (value >= 25) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0C0F1C), Color(0xFF1A1F36)],
          ),
        ),
        child: SafeArea(
          child:
              gameState == 'welcome'
                  ? buildWelcomeScreen()
                  : gameState == 'playing'
                  ? buildGameScreen()
                  : gameState == 'fact'
                  ? buildFactScreen()
                  : buildGameOverScreen(),
        ),
      ),
    );
  }

  Widget buildWelcomeScreen() {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Column(
                    children: [
                      Text('🌍', style: TextStyle(fontSize: 100)),
                      SizedBox(height: 20),
                      ShaderMask(
                        shaderCallback:
                            (bounds) => LinearGradient(
                              colors: [Colors.cyan, Colors.purple],
                            ).createShader(bounds),
                        child: Text(
                          'Solar Defender',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '🚀 Protect Earth from Solar Storms',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.cyanAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 50),
            if (playerName.isEmpty)
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyanAccent, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      '🎮 What\'s your name, Space Commander?',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter your name here...',
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.cyanAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.cyanAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.purpleAccent,
                            width: 2,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          setState(() {
                            playerName = value.trim();
                          });
                          startCountdown();
                        }
                      },
                    ),
                  ],
                ),
              )
            else if (countdown > 0)
              Column(
                children: [
                  Text(
                    'Welcome Commander $playerName! 🎖',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Mission starting in...',
                    style: TextStyle(fontSize: 24, color: Colors.white70),
                  ),
                  SizedBox(height: 20),
                  Text(
                    countdown.toString(),
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildGameScreen() {
    if (solarFlares.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            if (errorMessage.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      );
    }
    final currentFlare = solarFlares[phase];
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Commander $playerName',
                    style: TextStyle(fontSize: 18, color: Colors.cyanAccent),
                  ),
                  Text(
                    'Score: $score',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                'Phase ${phase + 1}/${solarFlares.length}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Earth Animation
          AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value,
                child: Text('🌍', style: TextStyle(fontSize: 120)),
              );
            },
          ),
          SizedBox(height: 20),

          // Solar Flare Alert
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.3),
                  Colors.orange.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.redAccent, width: 2),
            ),
            child: Column(
              children: [
                Text(
                  '⚠ Solar Flare Detected!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Class: ${currentFlare.flareClass}',
                  style: TextStyle(fontSize: 32, color: Colors.yellowAccent),
                ),
                SizedBox(height: 10),
                Text(
                  currentFlare.impact,
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Earth Systems Status
          buildSystemStatus('⚡ Power Grid', powerGrid),
          SizedBox(height: 10),
          buildSystemStatus('🛰 Satellites', satellites),
          SizedBox(height: 10),
          buildSystemStatus('📡 Communications', communications),
          SizedBox(height: 10),
          buildSystemStatus('🌍 Earth Health', earthHealth),
          SizedBox(height: 30),

          // Message
          if (message.isNotEmpty)
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.greenAccent),
              ),
              child: Text(
                message,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(height: 20),

          // Defense Strategies
          Text(
            'Choose Defense Strategy:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          ...defenseStrategies.map((strategy) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () => handleDefense(strategy),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.withOpacity(0.7),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.cyanAccent, width: 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        strategy.name,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Text(
                      '${strategy.cost} points',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildFactScreen() {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '📚 Fun Fact!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.purpleAccent, width: 2),
              ),
              child: Text(
                currentFact,
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: proceedToNextPhase,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Continue to Next Phase',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSystemStatus(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
            Text(
              '${value.toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 20,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(getHealthColor(value)),
          ),
        ),
      ],
    );
  }

  Widget buildGameOverScreen() {
    final rank = getRank();
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              earthHealth > 0 ? '🎉 Mission Complete!' : '💥 Mission Failed!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: earthHealth > 0 ? Colors.greenAccent : Colors.redAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyanAccent, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'Commander $playerName',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Final Score: $score',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    rank,
                    style: TextStyle(fontSize: 28, color: Colors.cyanAccent),
                  ),
                  SizedBox(height: 30),
                  buildSystemStatus('🌍 Earth Health', earthHealth),
                  SizedBox(height: 10),
                  buildSystemStatus('⚡ Power Grid', powerGrid),
                  SizedBox(height: 10),
                  buildSystemStatus('🛰 Satellites', satellites),
                  SizedBox(height: 10),
                  buildSystemStatus('📡 Communications', communications),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                children: [
                  Text(
                    '📚 Educational Facts',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    educationalFacts.join('\n\n'),
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  gameState = 'welcome';
                  playerName = '';
                  score = 15;
                  phase = 0;
                  earthHealth = 100;
                  powerGrid = 100;
                  satellites = 100;
                  communications = 100;
                  countdown = 3;
                  message = '';
                  errorMessage = '';
                  fetchSolarFlares(); // Refetch for new game
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                '🎮 Play Again',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}