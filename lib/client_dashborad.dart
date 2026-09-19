import 'package:flutter/material.dart';
import 'package:ripal_design/resource/portfolio_card.dart';
import 'package:ripal_design/resource/custom_bottom_nav_bar.dart';
import 'package:ripal_design/client_contactus.dart';

class Client_Dashborad extends StatefulWidget {
  const Client_Dashborad({super.key});

  @override
  State<Client_Dashborad> createState() => _Client_DashboradState();
}

class _Client_DashboradState extends State<Client_Dashborad> {
  final Color titleColor = const Color(0xFF5A0000); // Dark maroon
  final Color textColor = const Color(0xFF4A1009);
  final Color primaryColor = const Color(0xFF9E4723);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F2), // Very light cream background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.grid_view_outlined, color: titleColor),
          onPressed: () {},
        ),
        title: Text(
          'Ripal Design',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 18,
            ),
          ),
        ],
        titleSpacing: -5.5,
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: titleColor,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientContactus(),
              ),
            );
            return;
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
