// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:math';

// class SolarFlare {
//   final String flareClass;
//   final double intensity;
//   final String impact;
//   final int damage;

//   SolarFlare({
//     required this.flareClass,
//     required this.intensity,
//     required this.impact,
//     required this.damage,
//   });
// }

// class DefenseStrategy {
//   final String id;
//   final String name;
//   final IconData icon;
//   final int cost;
//   final String protects;

//   DefenseStrategy({
//     required this.id,
//     required this.name,
//     required this.icon,
//     required this.cost,
//     required this.protects,
//   });
// }

// class SolarDefenderGame extends StatefulWidget {
//   const SolarDefenderGame({super.key});

//   @override
//   _SolarDefenderGameState createState() => _SolarDefenderGameState();
// }

// class _SolarDefenderGameState extends State<SolarDefenderGame>
//     with TickerProviderStateMixin {
//   String gameState = 'welcome'; // welcome, playing, gameover
//   String playerName = '';
//   int score = 15;
//   int phase = 0;
//   double earthHealth = 100;
//   double powerGrid = 100;
//   double satellites = 100;
//   double communications = 100;
//   int countdown = 3;
//   String message = '';
//   bool showStats = false;

//   late AnimationController _pulseController;
//   late AnimationController _rotateController;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _rotateAnimation;

//   final List<SolarFlare> solarFlares = [
//     SolarFlare(
//         flareClass: 'C1.5',
//         intensity: 1.5,
//         impact: 'اضطرابات بسيطة متوقعة',
//         damage: 5),
//     SolarFlare(
//         flareClass: 'M2.1',
//         intensity: 2.1,
//         impact: 'تقلبات محتملة في شبكة الكهرباء!',
//         damage: 15),
//     SolarFlare(
//         flareClass: 'X1.3',
//         intensity: 1.3,
//         impact: 'البنية التحتية الحرجة في خطر!',
//         damage: 30),
//     SolarFlare(
//         flareClass: 'B3.2',
//         intensity: 3.2,
//         impact: 'تأثير ضئيل متوقع',
//         damage: 3),
//     SolarFlare(
//         flareClass: 'M5.5',
//         intensity: 5.5,
//         impact: 'تداخل شديد في الأقمار الصناعية!',
//         damage: 20),
//   ];

//   final List<DefenseStrategy> defenseStrategies = [
//     DefenseStrategy(
//         id: 'satellite',
//         name: '🛡 حماية الأقمار',
//         icon: Icons.shield,
//         cost: 10,
//         protects: 'satellites'),
//     DefenseStrategy(
//         id: 'power',
//         name: '⚡ حماية الكهرباء',
//         icon: Icons.flash_on,
//         cost: 15,
//         protects: 'powerGrid'),
//     DefenseStrategy(
//         id: 'comms',
//         name: '📡 تعزيز الاتصالات',
//         icon: Icons.signal_cellular_alt,
//         cost: 8,
//         protects: 'communications'),
//     DefenseStrategy(
//         id: 'full',
//         name: '🎯 دفاع شامل',
//         icon: Icons.security,
//         cost: 20,
//         protects: 'all'),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pulseController = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);

//     _rotateController = AnimationController(
//       duration: Duration(seconds: 20),
//       vsync: this,
//     )..repeat();

//     _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );

//     _rotateAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
//       CurvedAnimation(parent: _rotateController, curve: Curves.linear),
//     );
//   }

//   @override
//   void dispose() {
//     _pulseController.dispose();
//     _rotateController.dispose();
//     super.dispose();
//   }

//   void startCountdown() {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       if (countdown > 0) {
//         setState(() {
//           countdown--;
//         });
//       } else {
//         timer.cancel();
//         setState(() {
//           gameState = 'playing';
//         });
//       }
//     });
//   }

//   void calculateEarthHealth() {
//     setState(() {
//       earthHealth = (powerGrid + satellites + communications) / 3;
//     });
//   }

//   void handleDefense(DefenseStrategy strategy) {
//     if (score < strategy.cost) {
//       setState(() {
//         message = '⚠ ليس لديك نقاط كافية!';
//       });
//       Timer(Duration(seconds: 2), () {
//         setState(() {
//           message = '';
//         });
//       });
//       return;
//     }

//     int newScore = score - strategy.cost;
//     final flare = solarFlares[phase];
//     final damage = flare.damage.toDouble();

//     setState(() {
//       if (strategy.protects == 'all') {
//         powerGrid = min(100, powerGrid + 10);
//         satellites = min(100, satellites + 10);
//         communications = min(100, communications + 10);
//         newScore += 25;
//         message = '✅ دفاع ناجح! حماية شاملة للأرض!';
//       } else if (strategy.protects == 'satellites') {
//         satellites = max(0, satellites - (damage * 0.3));
//         powerGrid = max(0, powerGrid - damage);
//         communications = max(0, communications - damage);
//         newScore += 15;
//         message = '🛡 تم حماية الأقمار الصناعية!';
//       } else if (strategy.protects == 'powerGrid') {
//         powerGrid = max(0, powerGrid - (damage * 0.3));
//         satellites = max(0, satellites - damage);
//         communications = max(0, communications - damage);
//         newScore += 20;
//         message = '⚡ تم حماية شبكات الكهرباء!';
//       } else if (strategy.protects == 'communications') {
//         communications = max(0, communications - (damage * 0.3));
//         powerGrid = max(0, powerGrid - damage);
//         satellites = max(0, satellites - damage);
//         newScore += 12;
//         message = '📡 تم تعزيز الاتصالات!';
//       }

//       score = newScore;
//       calculateEarthHealth();
//     });

//     Timer(Duration(seconds: 2), () {
//       setState(() {
//         message = '';
//         phase++;
//         if (phase >= solarFlares.length || earthHealth <= 0) {
//           gameState = 'gameover';
//         }
//       });
//     });
//   }

//   String getRank() {
//     if (score >= 80) return '🌟 Solar Defender Master';
//     if (score >= 50) return '🎖 Space Commander';
//     if (score >= 25) return '🚀 Space Cadet';
//     return '⭐ Space Beginner';
//   }

//   Color getHealthColor(double value) {
//     if (value >= 75) return Colors.green;
//     if (value >= 50) return Colors.yellow;
//     if (value >= 25) return Colors.orange;
//     return Colors.red;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF1a1a2e),
//               Color(0xFF16213e),
//               Color(0xFF0f3460),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: gameState == 'welcome'
//               ? buildWelcomeScreen()
//               : gameState == 'playing'
//                   ? buildGameScreen()
//                   : buildGameOverScreen(),
//         ),
//       ),
//     );
//   }

//   Widget buildWelcomeScreen() {
//     return Center(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AnimatedBuilder(
//               animation: _pulseAnimation,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _pulseAnimation.value,
//                   child: Column(
//                     children: [
//                       Text(
//                         '🌍',
//                         style: TextStyle(fontSize: 100),
//                       ),
//                       SizedBox(height: 20),
//                       ShaderMask(
//                         shaderCallback: (bounds) => LinearGradient(
//                           colors: [Colors.cyan, Colors.purple],
//                         ).createShader(bounds),
//                         child: Text(
//                           'Solar Defender',
//                           style: TextStyle(
//                             fontSize: 48,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         '🚀 حماية الأرض من الانفجارات الشمسية',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.cyanAccent,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 50),
//             if (playerName.isEmpty)
//               Container(
//                 padding: EdgeInsets.all(30),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.cyanAccent, width: 2),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       '🎮 ما اسمك أيها القائد الفضائي؟',
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20),
//                     TextField(
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: 'اكتب اسمك هنا...',
//                         hintStyle: TextStyle(color: Colors.white54),
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.2),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.cyanAccent),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.cyanAccent),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide:
//                               BorderSide(color: Colors.purpleAccent, width: 2),
//                         ),
//                       ),
//                       onSubmitted: (value) {
//                         if (value.trim().isNotEmpty) {
//                           setState(() {
//                             playerName = value.trim();
//                           });
//                           startCountdown();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             else if (countdown > 0)
//               Column(
//                 children: [
//                   Text(
//                     'مرحباً القائد $playerName! 🎖',
//                     style: TextStyle(
//                       fontSize: 28,
//                       color: Colors.greenAccent,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 30),
//                   Text(
//                     'بدء المهمة في...',
//                     style: TextStyle(fontSize: 24, color: Colors.white70),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     countdown.toString(),
//                     style: TextStyle(
//                       fontSize: 80,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.cyanAccent,
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildGameScreen() {
//     final currentFlare = solarFlares[phase];
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'القائد $playerName',
//                     style: TextStyle(fontSize: 18, color: Colors.cyanAccent),
//                   ),
//                   Text(
//                     'النقاط: $score',
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ],
//               ),
//               Text(
//                 'المرحلة ${phase + 1}/5',
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),

//           // Earth Animation
//           AnimatedBuilder(
//             animation: _rotateAnimation,
//             builder: (context, child) {
//               return Transform.rotate(
//                 angle: _rotateAnimation.value,
//                 child: Text(
//                   '🌍',
//                   style: TextStyle(fontSize: 120),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 20),

//           // Solar Flare Alert
//           Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.red.withOpacity(0.3), Colors.orange.withOpacity(0.3)],
//               ),
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.redAccent, width: 2),
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   '⚠ انفجار شمسي مكتشف!',
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'الفئة: ${currentFlare.flareClass}',
//                   style: TextStyle(fontSize: 32, color: Colors.yellowAccent),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   currentFlare.impact,
//                   style: TextStyle(fontSize: 18, color: Colors.white70),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),

//           // Earth Systems Status
//           buildSystemStatus('⚡ شبكة الكهرباء', powerGrid),
//           SizedBox(height: 10),
//           buildSystemStatus('🛰 الأقمار الصناعية', satellites),
//           SizedBox(height: 10),
//           buildSystemStatus('📡 الاتصالات', communications),
//           SizedBox(height: 10),
//           buildSystemStatus('🌍 صحة الأرض', earthHealth),
//           SizedBox(height: 30),

//           // Message
//           if (message.isNotEmpty)
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.greenAccent),
//               ),
//               child: Text(
//                 message,
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           SizedBox(height: 20),

//           // Defense Strategies
//           Text(
//             'اختر استراتيجية الدفاع:',
//             style: TextStyle(
//                 fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           SizedBox(height: 15),
//           ...defenseStrategies.map((strategy) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 10),
//               child: ElevatedButton(
//                 onPressed: () => handleDefense(strategy),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blueAccent.withOpacity(0.7),
//                   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     side: BorderSide(color: Colors.cyanAccent, width: 2),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         strategy.name,
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                     Text(
//                       '${strategy.cost} نقطة',
//                       style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   Widget buildSystemStatus(String label, double value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//             Text(
//               '${value.toStringAsFixed(0)}%',
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ],
//         ),
//         SizedBox(height: 5),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: LinearProgressIndicator(
//             value: value / 100,
//             minHeight: 20,
//             backgroundColor: Colors.grey[800],
//             valueColor: AlwaysStoppedAnimation<Color>(getHealthColor(value)),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildGameOverScreen() {
//     final rank = getRank();
//     return Center(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               earthHealth > 0 ? '🎉 المهمة مكتملة!' : '💥 المهمة فشلت!',
//               style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                   color: earthHealth > 0 ? Colors.greenAccent : Colors.redAccent),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 30),
//             Container(
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.cyanAccent, width: 2),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     'القائد $playerName',
//                     style: TextStyle(fontSize: 24, color: Colors.white),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     'النقاط النهائية: $score',
//                     style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.yellowAccent),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     rank,
//                     style: TextStyle(fontSize: 28, color: Colors.cyanAccent),
//                   ),
//                   SizedBox(height: 30),
//                   buildSystemStatus('🌍 صحة الأرض', earthHealth),
//                   SizedBox(height: 10),
//                   buildSystemStatus('⚡ شبكة الكهرباء', powerGrid),
//                   SizedBox(height: 10),
//                   buildSystemStatus('🛰 الأقمار الصناعية', satellites),
//                   SizedBox(height: 10),
//                   buildSystemStatus('📡 الاتصالات', communications),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(color: Colors.blueAccent),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     '📚 حقائق تعليمية',
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     '☀ الانفجارات الشمسية تسافر بسرعة الضوء!\n\n'
//                     '🛰 يمكن أن تعطل الأقمار الصناعية والاتصالات\n\n'
//                     '⚡ قد تؤثر على شبكات الكهرباء على الأرض\n\n'
//                     '🌍 ناسا تراقب الطقس الفضائي لحمايتنا',
//                     style: TextStyle(fontSize: 16, color: Colors.white70),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   gameState = 'welcome';
//                   playerName = '';
//                   score = 0;
//                   phase = 0;
//                   earthHealth = 100;
//                   powerGrid = 100;
//                   satellites = 100;
//                   communications = 100;
//                   countdown = 3;
//                   message = '';
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purpleAccent,
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: Text(
//                 '🎮 العب مرة أخرى',
//                 style: TextStyle(fontSize: 20, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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

class SolarDefenderGame extends StatefulWidget {
  const SolarDefenderGame({super.key});

  @override
  _SolarDefenderGameState createState() => _SolarDefenderGameState();
}

class _SolarDefenderGameState extends State<SolarDefenderGame>
    with TickerProviderStateMixin {
  String gameState = 'welcome'; // welcome, playing, gameover
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

  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  final List<SolarFlare> solarFlares = [
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

    setState(() {
      if (strategy.protects == 'all') {
        powerGrid = min(100, powerGrid + 10);
        satellites = min(100, satellites + 10);
        communications = min(100, communications + 10);
        newScore += 25;
        message = '✅ Successful defense! Full Earth protection!';
      } else if (strategy.protects == 'satellites') {
        satellites = max(0, satellites - (damage * 0.3));
        powerGrid = max(0, powerGrid - damage);
        communications = max(0, communications - damage);
        newScore += 15;
        message = '🛡 Satellites protected!';
      } else if (strategy.protects == 'powerGrid') {
        powerGrid = max(0, powerGrid - (damage * 0.3));
        satellites = max(0, satellites - damage);
        communications = max(0, communications - damage);
        newScore += 20;
        message = '⚡ Power grid protected!';
      } else if (strategy.protects == 'communications') {
        communications = max(0, communications - (damage * 0.3));
        powerGrid = max(0, powerGrid - damage);
        satellites = max(0, satellites - damage);
        newScore += 12;
        message = '📡 Communications boosted!';
      }

      score = newScore;
      calculateEarthHealth();
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        message = '';
        phase++;
        if (phase >= solarFlares.length || earthHealth <= 0) {
          gameState = 'gameover';
        }
      });
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
          ),
        ),
        child: SafeArea(
          child: gameState == 'welcome'
              ? buildWelcomeScreen()
              : gameState == 'playing'
              ? buildGameScreen()
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
                        shaderCallback: (bounds) => LinearGradient(
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
                'Phase ${phase + 1}/5',
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
                    '☀ Solar flares travel at the speed of light!\n\n'
                    '🛰 They can disrupt satellites and communications\n\n'
                    '⚡ May affect power grids on Earth\n\n'
                    '🌍 NASA monitors space weather to protect us',
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
