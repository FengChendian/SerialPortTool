import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:serialport_tool/home/config_bar.dart';
import 'package:serialport_tool/data_manager.dart';
import 'package:serialport_tool/home/data_display_window.dart';
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
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(900, 700);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "串口调试助手";
    win.show();
  });
}

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const borderColor = Color(0xFF805306);

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
          theme: ThemeData(
            accentColor: appTheme.color,
            fontFamily: "NotoSans SC",
            brightness: appTheme.mode == ThemeMode.system
                ? darkMode
                    ? Brightness.dark
                    : Brightness.light
                : appTheme.mode == ThemeMode.dark
                    ? Brightness.dark
                    : Brightness.light,
            visualDensity: VisualDensity.standard,
            // acrylicBackgroundColor: Colors.white,
            scaffoldBackgroundColor: Color(0xfff1f0ed),
            // dividerTheme: DividerThemeData(
            //   decoration: BoxDecoration(
            //     color: Color(0xfff1f0ed),
            //   ),
            // ),
            // shadowColor: Colors.transparent,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final paneTextList = ["基本", "绘图"];

  MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
  final items = <NavigationPaneItem>[
    PaneItemHeader(header: Text('基本功能')),
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
        appBar: NavigationAppBar(
          height: appWindow.titleBarHeight,
          actions: MoveWindow(
            child: Row(
              children: [
                Spacer(),
                WindowButtons(),
              ],
            ),
          ),
          title: () {
            return MoveWindow(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("串口调试助手"),
              ),
            );
          }(),
        ),
        // useAcrylic: true,
        pane: NavigationPane(
          items: items,
          selected: navigationManager.index,
          onChanged: (index) {
            navigationManager.changeIndex(index);
          },
          displayMode: PaneDisplayMode.compact,
          autoSuggestBox: AutoSuggestBox(
            controller: TextEditingController(),
            items: paneTextList,
            onSelected: (String value) {
              navigationManager.changeIndex(paneTextList.indexOf(value));
            },
          ),
          autoSuggestBoxReplacement: Icon(Icons.search),
        ),
        content: NavigationBody(
          index: navigationManager.index,
          children: [
            ScaffoldPage(
                padding: EdgeInsets.symmetric(vertical: 8),
                content: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          child: ConfigBar(),
                          // opacity: 1,
                          // elevation: 1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // Divider(direction: Axis.vertical,),
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

const sidebarColor = Color(0xFFF6A00C);

class LeftSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Container(
            color: sidebarColor,
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                Expanded(child: Container())
              ],
            )));
  }
}

const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class RightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundStartColor, backgroundEndColor],
                  stops: [0.0, 1.0]),
            ),
            child: Column(children: [
              WindowTitleBarBox(
                  child: Row(children: [
                Expanded(child: MoveWindow()),
                WindowButtons()
              ])),
            ])));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Color(0xFF805306),
    mouseOver: Color(0xFFF6A00C),
    mouseDown: Color(0xFF805306),
    iconMouseOver: Color(0xFF805306),
    iconMouseDown: Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: Color(0xFFD32F2F),
    mouseDown: Color(0xFFB71C1C),
    iconNormal: Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    assert(debugCheckHasFluentLocalizations(context));
    final ThemeData theme = FluentTheme.of(context);
    final buttonColors = WindowButtonColors(
      iconNormal: theme.inactiveColor,
      iconMouseDown: theme.inactiveColor,
      iconMouseOver: theme.inactiveColor,
      mouseOver: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.hovering}),
      mouseDown: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.pressing}),
    );
    final closeButtonColors = WindowButtonColors(
      mouseOver: Colors.red,
      mouseDown: Colors.red.dark,
      iconNormal: theme.inactiveColor,
      iconMouseOver: Colors.red.basedOnLuminance(),
      iconMouseDown: Colors.red.dark.basedOnLuminance(),
    );
    return Row(children: [
      Tooltip(
        message: FluentLocalizations.of(context).minimizeWindowTooltip,
        child: MinimizeWindowButton(colors: buttonColors),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).restoreWindowTooltip,
        child: MaximizeWindowButton(colors: buttonColors),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).closeWindowTooltip,
        child: CloseWindowButton(colors: closeButtonColors),
      ),
    ]);
  }
}
