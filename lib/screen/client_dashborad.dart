import 'package:flutter/material.dart';
import 'package:ripal_design/resource/portfolio_card.dart';
import 'package:ripal_design/resource/client_scaffold.dart';
import 'package:ripal_design/screen/client_contactus.dart';
import 'package:ripal_design/screen/client_project_view.dart';
import 'package:ripal_design/screen/client_applay.dart';
import 'package:ripal_design/screen/client_settings.dart';

class Client_Dashborad extends StatefulWidget {
  const Client_Dashborad({super.key});

  @override
  State<Client_Dashborad> createState() => _Client_DashboradState();
}

class _Client_DashboradState extends State<Client_Dashborad> {
  final Color titleColor = const Color(0xFF5A0000);
  final Color primaryColor = const Color(0xFF9E4723);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClientScaffold(
      currentIndex: _currentIndex,
      onFabPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClientApplay()),
        );
      },
      onNavTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ClientProjectView()),
          );
          return;
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ClientContactus()),
          );
          return;
        }
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ClientSettings()),
          );
          return;
        }
        setState(() => _currentIndex = index);
      },
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Text(
                'Welcome\nour Side',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                  height: 1.1,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Real-time structural performance and\nfinancial overview.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              // Active Portfolio Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Active\nPortfolio',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: titleColor,
                      height: 1.1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'View',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Management',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Portfolio Cards
              const PortfolioCard(
                title: 'Sahara Retreat',
                value: '1.2L',
                badgeText: 'PLANNING',
                badgeColor: Color(0xFF6C2B2B),
                progress: 0.35,
                progressText: '35% Completed',
              ),
              const PortfolioCard(
                title: 'The Vertical Garden',
                value: '2.8Cr',
                badgeText: 'CONSTRUCTION',
                badgeColor: Color(0xFFA0604A),
                progress: 0.78,
                progressText: '78% Completed',
              ),
              const PortfolioCard(
                title: 'Lake Obsidian',
                value: '8.4Cr',
                badgeText: 'FINISHING',
                badgeColor: Color(0xFF3B5274),
                progress: 0.92,
                progressText: '92% Completed',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
