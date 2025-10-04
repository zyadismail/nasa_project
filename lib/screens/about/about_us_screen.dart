import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});
  final List<TeamMember> team = [
    TeamMember(
      name: "Mohamed",
      role: "Web Developer",
      imagePath: "assets/members/mohamed.jpg",
      githubUrl: "https://github.com/samira",
      linkedinUrl: "https://www.linkedin.com/in/mohamed-omara-b549b5356?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
    ),
    TeamMember(
      name: "ziad",
      role: "Mobile developer",
      imagePath: "assets/members/ziad.jpg",
      githubUrl: "https://github.com/zyadismail",
      linkedinUrl: "https://www.linkedin.com/in/ziadismail1/",
    ),
    TeamMember(
      name: "Ahmed",
      role: "Mobile Developer",
      imagePath: "assets/members/ahmed.jpg",
      githubUrl: "https://github.com/ahmed",
      linkedinUrl: "https://www.linkedin.com/in/ahmed-wael-3765572b2?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
    ),
    TeamMember(
      name: "Amira",
      role: "Ai Engineer",
      imagePath: "assets/members/amira.jpg",
      githubUrl: "https://github.com/mustafa",
      linkedinUrl: "https://www.linkedin.com/in/amira-mohamed-nada?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app",
    ),
    TeamMember(
      name: "Mokhtar",
      role: "Ai Engineer and web developer",
      imagePath: "assets/members/mokhtar.jpg",
      githubUrl: "https://github.com/ali",
      linkedinUrl: "https://github.com/mokhtar919",
    ),
    TeamMember(
      name: "Esraa",
      role: "Accountant",
      imagePath: "assets/members/Esraa.jpg",
      githubUrl: "https://github.com/omar",
      linkedinUrl: "https://www.linkedin.com/in/esraa-bakry-615848274?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
    ),
  ];

  // Function to open URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset("assets/images/sun.jpg")),
            Container(color: Colors.black54),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Image.asset("assets/images/app_logo.png"),
                      SizedBox(height: 10),
                      Text(
                        "About Solar Defender",
                        style: TextStyle(
                          color: Color(0xff00FFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "A Nasa Space Apps Challenge Game",
                        style: TextStyle(color: Color(0xffFECA57)),
                      ),
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'The project aims to simplify space weather science into an engaging and useful experience through a smart monitoring system that delivers real-time data and early warnings, interactive educational games for all age groups, and awareness content such as videos, podcasts, and scientific guides.Its main impact is to raise public awareness and protection against space weather risks while inspiring interest in space sciences and preparing a generation ready to face future challenges',
                          style: TextStyle(color: Color(0xff4ECDC4),fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 100),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text(
                            "Team members - 6 members:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: team.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 30,
                                childAspectRatio: 0.5,
                              ),
                          itemBuilder: (context, index) {
                            final member = team[index];
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(member.imagePath),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  member.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  member.role,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _launchUrl(member.githubUrl);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/images/github_logo_clean.svg",
                                          height: 30,    
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _launchUrl(member.linkedinUrl);
                                      },
                                      child: Image.asset(
                                        "assets/images/linkedin.webp",
                                        height: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String role;
  final String imagePath; // Local asset or network image
  final String githubUrl;
  final String linkedinUrl;

  TeamMember({
    required this.name,
    required this.role,
    required this.imagePath,
    required this.githubUrl,
    required this.linkedinUrl,
  });
}

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class TeamMember {
//   final String name;
//   final String role;
//   final String imagePath; // Local asset or network image
//   final String githubUrl;
//   final String linkedinUrl;

//   TeamMember({
//     required this.name,
//     required this.role,
//     required this.imagePath,
//     required this.githubUrl,
//     required this.linkedinUrl,
//   });
// }

// class AboutUsScreen extends StatelessWidget {
//   AboutUsScreen({super.key});



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Solar Flares Explorer",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
         
//           ],
//         ),
//       ),
//     );
//   }
// }
