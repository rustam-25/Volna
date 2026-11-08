import 'package:flutter/material.dart';

void main() => runApp(const VolnaApp());

class VolnaApp extends StatelessWidget {
  const VolnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Волна',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111116),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9C4DFF),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Track {
  final String title;
  final String artist;
  const Track(this.title, this.artist);
}

const tracks = [
  Track('Ночной город', 'Волна Records'),
  Track('Пульс', 'Neon Sky'),
  Track('Без тебя', 'Ramil'),
  Track('Тишина', 'Luna'),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;
  Track current = tracks.first;
  bool playing = false;

  final pages = const [
    _HomeContent(),
    _SearchContent(),
    _LibraryContent(),
    _ProfileContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MiniPlayer(
            track: current,
            playing: playing,
            onPlay: () => setState(() => playing = !playing),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlayerScreen(
                  track: current,
                  playing: playing,
                ),
              ),
            ),
          ),
          NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (v) => setState(() => tab = v),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Главная'),
              NavigationDestination(icon: Icon(Icons.search), label: 'Поиск'),
              NavigationDestination(icon: Icon(Icons.library_music_outlined), selectedIcon: Icon(Icons.library_music), label: 'Моя музыка'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Профиль'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        Row(
          children: [
            const Icon(Icons.graphic_eq, color: Color(0xFFAA65FF), size: 36),
            const SizedBox(width: 10),
            Text('Волна', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: 'Поиск музыки, артистов и плейлистов',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFF25252D),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 22),
        Container(
          height: 190,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(colors: [Color(0xFF2A1B42), Color(0xFF101016)]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Волна', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Color(0xFFB576FF))),
              const Text('Твоя музыка.\nВсегда рядом.', style: TextStyle(fontSize: 18)),
              const Spacer(),
              FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.play_arrow), label: const Text('Слушать')),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const _SectionTitle('Рекомендации'),
        SizedBox(
          height: 205,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _PlaylistCard('Для настроения', Icons.nightlife),
              _PlaylistCard('Ночной вайб', Icons.dark_mode),
              _PlaylistCard('Топ-100', Icons.headphones),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const _SectionTitle('Новинки'),
        ...tracks.map((t) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 54, height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF25143E)]),
            ),
            child: const Icon(Icons.music_note),
          ),
          title: Text(t.title),
          subtitle: Text(t.artist),
          trailing: const Icon(Icons.more_vert),
        )),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(children: [
      Text(text, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      const Spacer(),
      const Text('Ещё', style: TextStyle(color: Color(0xFFAA65FF))),
    ]),
  );
}

class _PlaylistCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const _PlaylistCard(this.title, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    width: 150,
    margin: const EdgeInsets.only(right: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF24242C), borderRadius: BorderRadius.circular(22)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Center(child: Icon(icon, size: 58, color: const Color(0xFFB576FF)))),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const Text('Плейлист', style: TextStyle(color: Colors.white54)),
    ]),
  );
}

class _SearchContent extends StatelessWidget {
  const _SearchContent();
  @override
  Widget build(BuildContext context) => const Center(child: Text('Поиск музыки'));
}
class _LibraryContent extends StatelessWidget {
  const _LibraryContent();
  @override
  Widget build(BuildContext context) => const Center(child: Text('Моя музыка'));
}
class _ProfileContent extends StatelessWidget {
  const _ProfileContent();
  @override
  Widget build(BuildContext context) => const Center(child: Text('Профиль\nРегистрация будет подключена к серверу', textAlign: TextAlign.center));
}

class _MiniPlayer extends StatelessWidget {
  final Track track;
  final bool playing;
  final VoidCallback onPlay;
  final VoidCallback onTap;
  const _MiniPlayer({required this.track, required this.playing, required this.onPlay, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
    color: const Color(0xFF202027),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(children: [
          Container(width: 45, height: 45, decoration: BoxDecoration(color: const Color(0xFF7C3AED), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.music_note)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(track.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(track.artist, style: const TextStyle(color: Colors.white54)),
          ])),
          IconButton(onPressed: onPlay, icon: Icon(playing ? Icons.pause : Icons.play_arrow)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next)),
        ]),
      ),
    ),
  );
}

class PlayerScreen extends StatefulWidget {
  final Track track;
  final bool playing;
  const PlayerScreen({super.key, required this.track, required this.playing});
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late bool playing;
  @override
  void initState() { super.initState(); playing = widget.playing; }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Сейчас играет')),
    body: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(children: [
        const Spacer(),
        Container(
          width: 300, height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: const LinearGradient(colors: [Color(0xFF9C4DFF), Color(0xFF21112F)]),
          ),
          child: const Icon(Icons.music_note, size: 100),
        ),
        const SizedBox(height: 36),
        Text(widget.track.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Text(widget.track.artist, style: const TextStyle(fontSize: 18, color: Colors.white60)),
        const SizedBox(height: 24),
        const LinearProgressIndicator(value: .35),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Icon(Icons.skip_previous, size: 40),
          IconButton(
            iconSize: 72,
            onPressed: () => setState(() => playing = !playing),
            icon: Icon(playing ? Icons.pause_circle_filled : Icons.play_circle_fill),
          ),
          const Icon(Icons.skip_next, size: 40),
        ]),
        const Spacer(),
      ]),
    ),
  );
}
