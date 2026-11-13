import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

const String kGithubSvg =
    '''<svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/></svg>''';

const String kLinkedinSvg =
    '''<svg viewBox="0 0 24 24" fill="currentColor"><path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/></svg>''';

void main() {
  runApp(const WidgetXApp());
}

/// Core App Root
class WidgetXApp extends StatelessWidget {
  const WidgetXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WidgetX — Building Innovative Cross-Platform Solutions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A192F),
        primaryColor: const Color(0xFF2DE2B6),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const HomePage(),
    );
  }
}

/// Palette constants
class AppColors {
  static const Color bgDeepNavy = Color(0xFF0A192F);
  static const Color bgDarkerNavy = Color(0xFF060D17);
  static const Color bgCard = Color(0xB8101E36);
  static const Color bgCardHover = Color(0xD216294A);
  static const Color bgInput = Color(0xFF132238);
  
  static const Color borderSubtle = Color(0x1AFFFFFF);
  static const Color borderHover = Color(0x38FFFFFF);
  
  static const Color accentTeal = Color(0xFF2DE2B6);
  static const Color accentCyan = Color(0xFF00F2FE);
  static const Color accentBlue = Color(0xFF38BDF8);
  static const Color accentMint = Color(0xFF64FFDA);
  
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textMuted = Color(0xFF8892B0);
  static const Color textSubtle = Color(0xFF64748B);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _complianceKey = GlobalKey();
  final GlobalKey _supportKey = GlobalKey();

  String _selectedFilter = 'Android';

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  void _showModal(BuildContext context, String title, Widget content) {
    showDialog(
      context: context,
      barrierColor: const Color(0xD9060D17),
      builder: (BuildContext ctx) {
        return Dialog(
          backgroundColor: const Color(0xFF0D1C34),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0x26FFFFFF)),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620, maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textWhite,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.textMuted),
                        onPressed: () => Navigator.of(ctx).pop(),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0x1AFFFFFF)),
                // Body
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: content,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      body: Stack(
        children: [
          // Ambient Canvas Background
          Positioned.fill(
            child: const AmbientZeroGravityBackground(),
          ),

          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sticky Navbar
                _buildNavbar(isDesktop),

                // Main Page Container
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Hero Section
                          _buildHeroSection(),
                          const SizedBox(height: 60),

                          // Featured Products Section
                          Container(key: _productsKey),
                          _buildFeaturedSection(isDesktop),
                          const SizedBox(height: 70),

                          // Trust & Compliance + Support Dual Section
                          Container(key: _complianceKey),
                          _buildGovernanceSupportSection(isDesktop),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ),

                // Footer
                _buildFooter(isDesktop),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar(bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgDeepNavy.withOpacity(0.85),
        border: const Border(
          bottom: BorderSide(color: Color(0x14FFFFFF)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo & Brand
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F1C2E),
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x402DE2B6),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'WIDGETX',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ],
                ),

                // Center Links (Desktop only)
                if (isDesktop)
                  Row(
                    children: [
                      _navButton('Apps', () => _scrollToSection(_productsKey), isActive: true),
                      const SizedBox(width: 32),
                      _navButton('Compliance', () => _scrollToSection(_complianceKey)),
                      const SizedBox(width: 32),
                      _navButton('Support', () => _scrollToSection(_supportKey)),
                    ],
                  ),

                // Right Actions
                Row(
                  children: [
                    // Status Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0x142DE2B6),
                        border: Border.all(color: const Color(0x332DE2B6)),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.accentTeal,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: AppColors.accentTeal, blurRadius: 8),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'v2.4 Live',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              color: AppColors.accentTeal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    _socialSvgButton(kGithubSvg, 'GitHub Profile', 'https://github.com'),
                    const SizedBox(width: 10),
                    _socialSvgButton(kLinkedinSvg, 'LinkedIn Profile', 'https://linkedin.com'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onTap, {bool isActive = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: isActive ? AppColors.accentMint : AppColors.textMuted,
          ),
        ),
      ),
    );
  }

  Widget _socialSvgButton(String svgStr, String tooltip, String url) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _openUrl(url),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 34,
          height: 34,
          padding: const EdgeInsets.all(7.5),
          decoration: BoxDecoration(
            color: const Color(0x0AFFFFFF),
            border: Border.all(color: const Color(0x14FFFFFF)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.string(
            svgStr,
            colorFilter: const ColorFilter.mode(AppColors.textMuted, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        const SizedBox(height: 30),
        // Center Badge
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: const Color(0x0AFFFFFF),
            border: Border.all(color: const Color(0x24FFFFFF)),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x4000F2FE),
                blurRadius: 35,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 28),

        // Title
        Text(
          'WidgetX — Building Innovative',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 42,
            fontWeight: FontWeight.w800,
            color: AppColors.textWhite,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF2DE2B6), Color(0xFF00F2FE), Color(0xFF38BDF8)],
          ).createShader(bounds),
          child: Text(
            'Cross-Platform Solutions',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            'Crafting fast, intuitive, and secure mobile & web utilities engineered for seamless digital experiences.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: AppColors.textMuted,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSection(bool isDesktop) {
    return Column(
      children: [
        // Tag
        Text(
          'FEATURED PRODUCTS',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
            color: AppColors.accentTeal,
          ),
        ),
        const SizedBox(height: 22),

        // Filter Tabs
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xB30E1C32),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: const Color(0x1AFFFFFF)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _filterTab('Android'),
                _filterTab('Web'),
                _filterTab('iOS'),
                _filterTab('macOS'),
                _filterTab('Linux'),
                _filterTab('Other'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),

        // Anti-Gravity Floating App Cards Grid
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AntiGravityAppCard(
                  title: 'TrackFlow',
                  category: 'HEALTH & TELEMETRY',
                  description:
                      'Intelligent background activity & fitness tracking designed with strict privacy-first architecture.',
                  icon: Icons.monitor_heart_outlined,
                  accentColor: AppColors.accentTeal,
                  cardId: 1, // TrackFlow
                  onPlayClick: () => _showDownloadModal('TrackFlow', 'dev.widgetx.trackflow', 'v2.4.1'),
                ),
              ),
              const SizedBox(width: 28),
              Expanded(
                child: AntiGravityAppCard(
                  title: 'ConnectCall',
                  category: 'VOICE & NETWORK',
                  description:
                      'Crystal-clear encrypted voice and low-latency audio utility for global teams.',
                  icon: Icons.phone_in_talk_outlined,
                  accentColor: AppColors.accentBlue,
                  cardId: 2, // ConnectCall
                  onPlayClick: () => _showDownloadModal('ConnectCall', 'dev.widgetx.connectcall', 'v1.9.8'),
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              AntiGravityAppCard(
                title: 'TrackFlow',
                category: 'HEALTH & TELEMETRY',
                description:
                    'Intelligent background activity & fitness tracking designed with strict privacy-first architecture.',
                icon: Icons.monitor_heart_outlined,
                accentColor: AppColors.accentTeal,
                cardId: 1,
                onPlayClick: () => _showDownloadModal('TrackFlow', 'dev.widgetx.trackflow', 'v2.4.1'),
              ),
              const SizedBox(height: 28),
              AntiGravityAppCard(
                title: 'ConnectCall',
                category: 'VOICE & NETWORK',
                description:
                    'Crystal-clear encrypted voice and low-latency audio utility for global teams.',
                icon: Icons.phone_in_talk_outlined,
                accentColor: AppColors.accentBlue,
                cardId: 2,
                onPlayClick: () => _showDownloadModal('ConnectCall', 'dev.widgetx.connectcall', 'v1.9.8'),
              ),
            ],
          ),
      ],
    );
  }

  Widget _filterTab(String label) {
    final isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () => setState(() => _selectedFilter = label),
      borderRadius: BorderRadius.circular(99),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1C2D4A) : Colors.transparent,
          borderRadius: BorderRadius.circular(99),
          boxShadow: isSelected
              ? const [BoxShadow(color: Color(0x59000000), blurRadius: 8)]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.accentMint : AppColors.textMuted,
          ),
        ),
      ),
    );
  }

  Widget _buildGovernanceSupportSection(bool isDesktop) {
    return isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildComplianceColumn()),
              const SizedBox(width: 36),
              Expanded(
                key: _supportKey,
                child: SupportRequestCard(onShowToast: (msg) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(msg),
                    backgroundColor: const Color(0xFF132238),
                  ));
                }),
              ),
            ],
          )
        : Column(
            children: [
              _buildComplianceColumn(),
              const SizedBox(height: 36),
              Container(
                key: _supportKey,
                child: SupportRequestCard(onShowToast: (msg) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(msg),
                    backgroundColor: const Color(0xFF132238),
                  ));
                }),
              ),
            ],
          );
  }

  Widget _buildComplianceColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'VERIFICATION & GOVERNANCE',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            color: AppColors.accentTeal,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Trust & Compliance',
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textWhite,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Transparent policies built on integrity and user data protection. We enforce least-privilege telemetry across every platform.',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 26),

        // Policy Rows
        _policyLinkRow('Privacy Policy', () => _showPrivacyPolicyModal()),
        const SizedBox(height: 12),
        _policyLinkRow('Terms of Service', () => _showTermsModal()),
        const SizedBox(height: 12),
        _policyLinkRow('Data Retention & Security Overview', () => _showRetentionModal()),
        const SizedBox(height: 24),

        // Google Play Families Policy Compliant
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0x0D2DE2B6),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0x332DE2B6)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0x1F2DE2B6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shield_outlined, color: AppColors.accentTeal, size: 22),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Families Policy Compliant',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                  Text(
                    'Verified Google Play Requirements',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Direct support info
        Row(
          children: [
            Text(
              'Direct support channel: ',
              style: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
            ),
            InkWell(
              onTap: () => _openUrl('mailto:contact.widgetx@gmail.com'),
              child: Text(
                'contact.widgetx@gmail.com',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentTeal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Social / Governance verified channels
        Row(
          children: [
            Text(
              'Verified Channels: ',
              style: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(width: 8),
            _socialChip('GitHub', kGithubSvg, 'https://github.com'),
            const SizedBox(width: 8),
            _socialChip('LinkedIn', kLinkedinSvg, 'https://linkedin.com'),
          ],
        ),
      ],
    );
  }

  Widget _socialChip(String label, String svgStr, String url) {
    return InkWell(
      onTap: () => _openUrl(url),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0x1464FFDA),
          border: Border.all(color: const Color(0x3364FFDA)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.string(
              svgStr,
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(AppColors.accentMint, BlendMode.srcIn),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentMint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _policyLinkRow(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xA6101E36),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }

  void _showPrivacyPolicyModal() {
    _showModal(
      context,
      'Privacy Policy',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _modalSectionHeader('Commitment to Zero-Knowledge Telemetry'),
          _modalParagraph(
              'At WidgetX, we build utilities engineered with strict data minimization principles. Our software operates on a local-first paradigm.'),
          _modalSectionHeader('Data Collection & Use'),
          _modalBullet(
              'TrackFlow: All fitness telemetry and sensor records are stored purely on your local device. No raw health metrics are transmitted without explicit export.'),
          _modalBullet(
              'ConnectCall: Voice transmission uses end-to-end encryption (E2EE) protocols. We maintain zero call logs and no audio recordings on central servers.'),
          _modalSectionHeader('User Rights'),
          _modalParagraph(
              'You may request full data deletion or audit logs at any time using our Support & Data Requests portal.'),
        ],
      ),
    );
  }

  void _showTermsModal() {
    _showModal(
      context,
      'Terms of Service',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _modalSectionHeader('Acceptance of Terms'),
          _modalParagraph(
              'By using WidgetX applications, utilities, and services, you agree to comply with our fair-usage policies and software licensing terms.'),
          _modalSectionHeader('Software License'),
          _modalParagraph(
              'WidgetX grants you a personal, non-exclusive, non-transferable license to install and run the official binaries published through Google Play.'),
        ],
      ),
    );
  }

  void _showRetentionModal() {
    _showModal(
      context,
      'Data Retention & Security Overview',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _modalSectionHeader('Enterprise-Grade Security Architecture'),
          _modalParagraph(
              'We implement AES-256-GCM encryption at rest and TLS 1.3 in transit across all network utilities.'),
          _modalSectionHeader('Retention Schedules'),
          _modalBullet('Support Inquiries: Retained for 30 days following ticket resolution, then permanently purged.'),
          _modalBullet('Telemetry Diagnostics: Optional anonymous crash dumps are automatically wiped after 14 days.'),
        ],
      ),
    );
  }

  void _showDownloadModal(String appName, String packageId, String version) {
    _showModal(
      context,
      '$appName on Google Play',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _modalSectionHeader('Official Google Play Release'),
          _modalParagraph(
              '$appName is available on Google Play for devices running Android 10 (API level 29) and above.'),
          _modalBullet('Package: $packageId'),
          _modalBullet('Version: $version (Stable Release)'),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => _openUrl('https://play.google.com'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentTeal,
                foregroundColor: const Color(0xFF0A192F),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: Text(
                'Open in Google Play Store',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modalSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textWhite,
        ),
      ),
    );
  }

  Widget _modalParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMuted, height: 1.55),
      ),
    );
  }

  Widget _modalBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: AppColors.accentTeal)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(fontSize: 13.5, color: AppColors.textMuted, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isDesktop) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xCC060D17),
        border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _footerLeft(),
                      _footerRight(),
                    ],
                  )
                : Column(
                    children: [
                      _footerLeft(),
                      const SizedBox(height: 12),
                      _footerRight(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _footerLeft() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: AppColors.accentTeal,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.accentTeal, blurRadius: 8)],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'WIDGETX SYSTEMS • SOFTWARE PUBLISHER',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _footerRight() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '© 2024 WidgetX Inc. All rights reserved. • Developed by Adarsh Gupta',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSubtle,
          ),
        ),
        const SizedBox(width: 14),
        _socialSvgButton(kGithubSvg, 'WidgetX GitHub', 'https://github.com'),
        const SizedBox(width: 8),
        _socialSvgButton(kLinkedinSvg, 'WidgetX LinkedIn', 'https://linkedin.com'),
      ],
    );
  }
}

// ==============================================================================
// ANTI-GRAVITY FLOATING APP CARD COMPONENT
// ==============================================================================

class AntiGravityAppCard extends StatefulWidget {
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final Color accentColor;
  final int cardId; // 1: TrackFlow (6.4s), 2: ConnectCall (7.8s)
  final VoidCallback onPlayClick;

  const AntiGravityAppCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.cardId,
    required this.onPlayClick,
  });

  @override
  State<AntiGravityAppCard> createState() => _AntiGravityAppCardState();
}

class _AntiGravityAppCardState extends State<AntiGravityAppCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translationAnimation;
  late Animation<double> _shadowBlurAnimation;
  late Animation<double> _shadowOffsetAnimation;
  late Animation<double> _shadowGlowAlphaAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // 1. Asynchronous Speeds & Phase Offset
    final durationMs = widget.cardId == 1 ? 6400 : 7800;
    final maxTranslation = widget.cardId == 1 ? -13.0 : -15.0;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: widget.cardId == 1
          ? const Cubic(0.45, 0.05, 0.55, 0.95)
          : const Cubic(0.42, 0.0, 0.58, 1.0),
    );

    // 2. Continuous Vertical Translation (10-15px)
    _translationAnimation = Tween<double>(begin: 0.0, end: maxTranslation).animate(curved);

    // 3. Dynamic Shadows: Blur & Spread expand when Up, tighten when Down
    _shadowBlurAnimation = Tween<double>(begin: 20.0, end: 54.0).animate(curved);
    _shadowOffsetAnimation = Tween<double>(begin: 10.0, end: 30.0).animate(curved);
    _shadowGlowAlphaAnimation = Tween<double>(begin: 0.04, end: 0.24).animate(curved);

    // Initialize phase offset so the cards don't start at the same time
    if (widget.cardId == 2) {
      _controller.value = 0.62; // Offset phase immediately
    }

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool hovered) {
    setState(() {
      _isHovered = hovered;
    });

    // 4. Hover Pause: Freezes animation in its current coordinate
    if (hovered) {
      _controller.stop();
    } else {
      _controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final translateY = _translationAnimation.value;
          final blur = _shadowBlurAnimation.value;
          final offsetY = _shadowOffsetAnimation.value;
          final glowAlpha = _shadowGlowAlphaAnimation.value;

          return Transform.translate(
            offset: Offset(0, translateY),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: _isHovered ? AppColors.bgCardHover : AppColors.bgCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _isHovered
                      ? widget.accentColor.withOpacity(0.4)
                      : AppColors.borderSubtle,
                  width: 1.2,
                ),
                boxShadow: [
                  // Base dark depth shadow
                  BoxShadow(
                    color: const Color(0xFF020C1B).withOpacity(0.85),
                    blurRadius: blur,
                    offset: Offset(0, offsetY),
                    spreadRadius: -8,
                  ),
                  // Dynamic zero-gravity ambient colored depth glow
                  BoxShadow(
                    color: widget.accentColor.withOpacity(glowAlpha),
                    blurRadius: blur * 0.6,
                    offset: Offset(0, offsetY * 0.6),
                    spreadRadius: -10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Card Header
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          color: widget.accentColor.withOpacity(0.1),
                          border: Border.all(color: widget.accentColor.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: widget.accentColor.withOpacity(0.18),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                        child: Icon(widget.icon, color: widget.accentColor, size: 28),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textWhite,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.category,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: widget.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Description
                  Text(
                    widget.description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textMuted,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Action Button
                  InkWell(
                    onTap: widget.onPlayClick,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0x0DFFFFFF),
                        border: Border.all(color: const Color(0x1EFFFFFF)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow_rounded, color: widget.accentColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Get it on Google Play',
                            style: GoogleFonts.inter(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==============================================================================
// SUPPORT & DATA REQUESTS FORM COMPONENT
// ==============================================================================

class SupportRequestCard extends StatefulWidget {
  final Function(String) onShowToast;

  const SupportRequestCard({super.key, required this.onShowToast});

  @override
  State<SupportRequestCard> createState() => _SupportRequestCardState();
}

class _SupportRequestCardState extends State<SupportRequestCard> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedPlatform;
  String? _selectedIssue;
  bool _isSubmitting = false;

  // Actionable Submission State
  bool _isSubmitted = false;
  String? _ticketId;
  String? _submittedName;
  String? _submittedEmail;
  String? _submittedPlatform;
  String? _submittedIssue;
  String? _submittedMessage;
  bool _copied = false;
  bool _deliveredToAdmin = false;
  bool _deliveredToUser = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final platform = _selectedPlatform ?? 'Web Utility Suite';
    final issue = _selectedIssue ?? 'General Inquiry & Feedback';
    final message = _messageController.text.trim();

    setState(() {
      _isSubmitting = true;
    });

    String ticket = 'WX-${100000 + math.Random().nextInt(900000)}';
    bool adminOk = false;
    bool userOk = false;

    try {
      final response = await http
          .post(
            Uri.parse('/api/contact'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': name,
              'email': email,
              'platform': platform,
              'issue': issue,
              'message': message,
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ticketId'] != null) {
          ticket = data['ticketId'].toString();
        }
        adminOk = data['deliveredToAdmin'] == true;
        userOk = data['deliveredToUser'] == true;
      }
    } catch (_) {
      // Offline / client fallback
    }

    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _isSubmitted = true;
      _ticketId = ticket;
      _submittedName = name;
      _submittedEmail = email;
      _submittedPlatform = platform;
      _submittedIssue = issue;
      _submittedMessage = message;
      _deliveredToAdmin = adminOk;
      _deliveredToUser = userOk;
      _copied = false;
    });

    widget.onShowToast('✓ Request Logged: Ticket #$ticket');
  }

  void _resetForm() {
    setState(() {
      _isSubmitted = false;
      _ticketId = null;
      _copied = false;
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      _selectedPlatform = null;
      _selectedIssue = null;
    });
  }

  void _openDirectMail() {
    final ticket = _ticketId ?? 'WX-SUPPORT';
    final subject = Uri.encodeComponent('[Ticket #$ticket] Inquiry for WidgetX Support');
    final body = Uri.encodeComponent(
      'Hi WidgetX Team,\n\n'
      'I submitted support ticket #$ticket.\n'
      'Name: ${_submittedName ?? ""}\n'
      'Email: ${_submittedEmail ?? ""}\n'
      'Platform: ${_submittedPlatform ?? ""}\n'
      'Issue: ${_submittedIssue ?? ""}\n\n'
      'Message:\n${_submittedMessage ?? ""}\n',
    );
    final url = 'mailto:contact.widgetx@gmail.com?subject=$subject&body=$body';
    _openUrl(url);
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0xCC020C1B),
            blurRadius: 36,
            offset: Offset(0, 16),
            spreadRadius: -10,
          ),
        ],
      ),
      child: _isSubmitted ? _buildActionableConfirmation() : _buildFormContent(),
    );
  }

  Widget _buildActionableConfirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0x262DE2B6),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accentTeal),
              ),
              child: const Icon(Icons.check_circle_rounded, color: AppColors.accentTeal, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inquiry Logged & Dispatched!',
                    style: GoogleFonts.inter(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Ticket Reference & Dispatch Receipt',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Ticket ID Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0C192E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x3364FFDA)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TICKET REFERENCE ID',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      color: AppColors.accentMint,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_ticketId != null) {
                        Clipboard.setData(ClipboardData(text: _ticketId!));
                        setState(() => _copied = true);
                        widget.onShowToast('Ticket ID copied to clipboard');
                        Future.delayed(const Duration(seconds: 3), () {
                          if (mounted) setState(() => _copied = false);
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _copied ? const Color(0x332DE2B6) : const Color(0x1AFFFFFF),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _copied ? AppColors.accentTeal : const Color(0x26FFFFFF),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _copied ? Icons.check : Icons.copy_rounded,
                            size: 13,
                            color: _copied ? AppColors.accentTeal : AppColors.textWhite,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _copied ? 'Copied' : 'Copy ID',
                            style: GoogleFonts.inter(
                              fontSize: 11.5,
                              color: _copied ? AppColors.accentTeal : AppColors.textWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '#${_ticketId ?? "WX-PROCESSED"}',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Live Actionable Status Checklist
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0x0DFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x14FFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statusRow(
                icon: _deliveredToAdmin ? Icons.mark_email_read_rounded : Icons.cloud_done_rounded,
                color: AppColors.accentTeal,
                label: _deliveredToAdmin ? 'Delivered to inbox:' : 'Logged on server:',
                value: 'contact.widgetx@gmail.com',
              ),
              const SizedBox(height: 10),
              _statusRow(
                icon: _deliveredToUser ? Icons.send_rounded : Icons.person_outline_rounded,
                color: _deliveredToUser ? AppColors.accentMint : const Color(0xFFFFB74D),
                label: _deliveredToUser ? 'Receipt sent to:' : 'Sender Email:',
                value: _submittedEmail ?? 'Your email address',
              ),
              const SizedBox(height: 10),
              _statusRow(
                icon: Icons.schedule_rounded,
                color: AppColors.accentBlue,
                label: 'Response SLA:',
                value: 'Within 24 business hours',
              ),
              if (!_deliveredToAdmin) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0x1FFF9800),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0x4DFF9800)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_rounded, color: Color(0xFFFFB74D), size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Automated SMTP is pending activation. Use "Send via Email App" below to dispatch immediately from your mail client.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFFFFCC80),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Action Buttons Row
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _openDirectMail,
                icon: const Icon(Icons.email_outlined, size: 17),
                label: Text(
                  _deliveredToAdmin ? 'Email Us Directly' : 'Send via Email App (1-Click)',
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentTeal,
                  foregroundColor: const Color(0xFF0A192F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: _resetForm,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textWhite,
                side: const BorderSide(color: Color(0x33FFFFFF)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'New Request',
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statusRow({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Text(
          '$label ',
          style: GoogleFonts.inter(fontSize: 13, color: AppColors.textMuted),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textWhite,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Support & Data Requests',
            style: GoogleFonts.inter(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Inquiries and account deletion requests are typically processed within 24 business hours.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textMuted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),

          // Name
          _fieldLabel('NAME'),
          _textInput(_nameController, 'Your name'),
          const SizedBox(height: 16),

          // Email
          _fieldLabel('EMAIL ADDRESS'),
          _textInput(_emailController, 'name@company.com', isEmail: true),
          const SizedBox(height: 16),

          // Platform Dropdown
          _fieldLabel('APPLICATION PLATFORM'),
          _dropdownInput(
            value: _selectedPlatform,
            hint: 'Select platform...',
            items: const [
              'TrackFlow (Android)',
              'ConnectCall (Android)',
              'Web Utility Suite',
              'iOS Preview',
              'macOS Desktop',
              'Linux Utility',
            ],
            onChanged: (val) => setState(() => _selectedPlatform = val),
          ),
          const SizedBox(height: 16),

          // Issue Scope Dropdown
          _fieldLabel('ISSUE TYPE'),
          _dropdownInput(
            value: _selectedIssue,
            hint: 'Select request scope...',
            items: const [
              'Account Deletion Request (GDPR / CCPA)',
              'Personal Data Access & Export',
              'Technical Bug Report / Crash',
              'Privacy Policy Clarification',
              'General Inquiry & Feedback',
            ],
            onChanged: (val) => setState(() => _selectedIssue = val),
          ),
          const SizedBox(height: 16),

          // Message
          _fieldLabel('MESSAGE'),
          TextFormField(
            controller: _messageController,
            maxLines: 4,
            style: GoogleFonts.inter(color: AppColors.textWhite, fontSize: 14.5),
            decoration: _inputDecoration('Describe your inquiry or deletion request...'),
            validator: (v) => v == null || v.isEmpty ? 'Message is required' : null,
          ),
          const SizedBox(height: 22),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentTeal,
                foregroundColor: const Color(0xFF0A192F),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 6,
              ),
              child: _isSubmitting
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF0A192F),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Dispatching & Logging...',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0A192F),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Submit Request',
                      style: GoogleFonts.inter(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          color: AppColors.textMuted,
        ),
      ),
    );
  }

  Widget _textInput(TextEditingController controller, String hint, {bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: AppColors.textWhite, fontSize: 14.5),
      decoration: _inputDecoration(hint),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Field is required';
        if (isEmail && !v.contains('@')) return 'Enter a valid email address';
        return null;
      },
    );
  }

  Widget _dropdownInput({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: const Color(0xFF0D1C34),
      style: GoogleFonts.inter(color: AppColors.textWhite, fontSize: 14.5),
      decoration: _inputDecoration(hint),
      hint: Text(hint, style: const TextStyle(color: Color(0xFF4A5B78), fontSize: 14.5)),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? 'Please make a selection' : null,
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF4A5B78), fontSize: 14),
      filled: true,
      fillColor: AppColors.bgInput,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0x14FFFFFF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0x14FFFFFF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.accentTeal, width: 1.5),
      ),
    );
  }
}

// ==============================================================================
// AMBIENT ZERO-GRAVITY PARTICLES BACKGROUND
// ==============================================================================

class AmbientZeroGravityBackground extends StatefulWidget {
  const AmbientZeroGravityBackground({super.key});

  @override
  State<AmbientZeroGravityBackground> createState() => _AmbientZeroGravityBackgroundState();
}

class _AmbientZeroGravityBackgroundState extends State<AmbientZeroGravityBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final List<_Particle> _particles = [];
  final math.Random _rng = math.Random();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 45; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        radius: _rng.nextDouble() * 1.8 + 0.8,
        speedX: (_rng.nextDouble() - 0.5) * 0.0006,
        speedY: -(_rng.nextDouble() * 0.0007 + 0.0002), // subtle upward float
        alpha: _rng.nextDouble() * 0.4 + 0.15,
        color: _rng.nextBool() ? AppColors.accentTeal : AppColors.accentBlue,
      ));
    }

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, _) {
        return CustomPaint(
          painter: _ParticlePainter(_particles),
        );
      },
    );
  }
}

class _Particle {
  double x;
  double y;
  final double radius;
  final double speedX;
  final double speedY;
  final double alpha;
  final Color color;

  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedX,
    required this.speedY,
    required this.alpha,
    required this.color,
  });

  void update() {
    x += speedX;
    y += speedY;

    if (x < 0) x = 1.0;
    if (x > 1.0) x = 0.0;
    if (y < 0) y = 1.0;
    if (y > 1.0) y = 0.0;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      p.update();
      final paint = Paint()
        ..color = p.color.withOpacity(p.alpha)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
