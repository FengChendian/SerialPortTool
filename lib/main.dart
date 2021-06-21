import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Scaffold, VerticalDivider;
import 'package:provider/provider.dart';
import 'package:serialport_tool/config_bar.dart';
import 'package:serialport_tool/data_manager.dart';
import 'package:serialport_tool/data_display_window.dart';
import 'package:serialport_tool/line_plot.dart';
import 'package:serialport_tool/theme.dart';
import 'package:system_theme/system_theme.dart';

late bool darkMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // The platforms the plugin support (01/04/2021 - DD/MM/YYYY):
  //   - Windows
  //   - Web
  //   - Android
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.android ||
      kIsWeb) {
    darkMode = await SystemTheme.darkMode;
    await SystemTheme.accentInstance.load();
  } else {
    darkMode = true;
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => DataManager(),
      // lazy: false,
    ),
    ChangeNotifierProvider(create: (_) => FluentNavigationManager()),
  ], child: MyApp()));
}

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: 'serial tool',
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {'/': (_) => MyHomePage()},
          theme:
              ThemeData(accentColor: appTheme.color, fontFamily: "NotoSans SC"
                  // brightness: appTheme.mode == ThemeMode.system
                  //     ? darkMode
                  //         ? Brightness.dark
                  //         : Brightness.light
                  //     : appTheme.mode == ThemeMode.dark
                  //         ? Brightness.dark
                  //         : Brightness.light,
                  // visualDensity: VisualDensity.standard,
                  // focusTheme: FocusThemeData(
                  //   glowFactor: is10footScreen() ? 2.0 : 0.0,
                  // ),
                  ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
  final items = <NavigationPaneItem>[
    PaneItem(
      icon: Icon(Icons.settings_input_component),
      title: Text("基本"),
    ),
    PaneItem(
      icon: Icon(Icons.scatter_plot),
      title: Text("绘图"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FluentNavigationManager>(
      builder: (_, navigationManager, __) => NavigationView(
        useAcrylic: false,
        pane: NavigationPane(
          items: items,
          selected: navigationManager.index,
          onChanged: (index) {
            navigationManager.changeIndex(index);
          },
          displayMode: PaneDisplayMode.compact,
        ),
        content: NavigationBody(
          index: navigationManager.index,
          children: [
            Scaffold(
                body: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ConfigBar(),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: DataDisplayWindow(),
                ),
              ],
            )),
            LineChartSample7(),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class FluentNavigationManager with ChangeNotifier {
  var _index = 0;

  int get index => _index;

  changeIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
