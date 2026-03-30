import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'gemini_service.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  bool _isLoading = false;
  String _result = '';

  void _handleAnalyze() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() { _isLoading = true; _result = ''; });

    try {
      final analysis = await _geminiService.analyzeScenario(_controller.text);
      setState(() => _result = analysis);
    } catch (e) {
      setState(() => _result = 'Error connecting to AI. Check your API Key.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('PILI-PINO', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, letterSpacing: 4, color: isDark ? AppTheme.kGold : AppTheme.kBlue)),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark ? [AppTheme.kNavy, AppTheme.kDeepNavy] : [const Color(0xFFF8FAFC), const Color(0xFFF1F5F9)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildInputSection(isDark),
              Expanded(child: _buildResultSection(isDark)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
        ),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Ano ang iyong pinagpipilian?',
                hintStyle: TextStyle(color: isDark ? Colors.white24 : Colors.black26),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            _buildAction(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(bool isDark) {
    return InkWell(
      onTap: _isLoading ? null : _handleAnalyze,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: isDark ? [AppTheme.kGold, const Color(0xFFFFB300)] : [AppTheme.kBlue, const Color(0xFF1E40AF)]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: _isLoading
              ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text('SURIIN NGAYON', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: isDark ? Colors.black : Colors.white, letterSpacing: 1.5)),
        ),
      ),
    );
  }

  Widget _buildResultSection(bool isDark) {
    if (_result.isEmpty && !_isLoading) {
      return Center(
          child: Icon(
              Icons.auto_awesome_rounded,
              size: 60,
              color: isDark ? Colors.white12 : Colors.black12 // Dynamic icon color
          )
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.kDeepNavy.withOpacity(0.5) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
      ),
      child: Markdown(
        data: _result,
        styleSheet: MarkdownStyleSheet(
          h3: TextStyle(
              color: isDark ? AppTheme.kGold : AppTheme.kBlue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 2.5
          ),
          //Itim ang text sa Light Mode, Puti sa Dark Mode
          p: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: isDark ? Colors.white70 : Colors.black87
          ),
          tableHead: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
          tableBorder: TableBorder.all(
              color: isDark ? Colors.white10 : Colors.black12
          ),
        ),
      ),
    );
  }
}