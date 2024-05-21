import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setting_model.dart';
export 'setting_model.dart';
import 'package:mud_safety/get_Info/Timer.dart';
import 'package:mud_safety/get_Info/get_data.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

/*class _SettingWidgetState extends State<SettingWidget> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _result1 = "";
  String _result2 = "";

  void _printTexts() {
    Data.Weather_Pressure = double.parse(_controller1.text);
    Data.Correction = double.parse(_controller2.text);
    updateSettingTime();
    setState(() {
      _result1 = _controller1.text;
      _result2 = _controller2.text;
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple TextField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                labelText: 'Enter first text',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                labelText: 'Enter second text',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _printTexts,
              child: Text('Print Texts'),
            ),
            SizedBox(height: 20),
            Text(
              'First Text: $_result1',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Second Text: $_result2',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}*/

class _SettingWidgetState extends State<SettingWidget> {
  late SettingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings Page',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
            fontFamily: 'Outfit',
            letterSpacing: 0.0,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Choose what notifcations you want to recieve below and we will update the settings.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
            child: SwitchListTile.adaptive(
              value: _model.switchListTileValue1 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.switchListTileValue1 = newValue!);
              },
              title: Text(
                'Push Notifications',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Plus Jakarta Sans',
                  letterSpacing: 0.0,
                  lineHeight: 2.0,
                ),
              ),
              subtitle: Text(
                'Receive Push notifications from our application on a semi regular basis.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF8B97A2),
                  letterSpacing: 0.0,
                ),
              ),
              tileColor: FlutterFlowTheme.of(context).secondaryBackground,
              activeColor: FlutterFlowTheme.of(context).primary,
              activeTrackColor: FlutterFlowTheme.of(context).accent1,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding:
              EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
            ),
          ),
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
            ),
            child: CheckboxListTile(
              value: _model.checkboxListTileValue1 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.checkboxListTileValue1 = newValue!);
              },
              title: Text(
                '5min',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  fontSize: 17.0,
                  letterSpacing: 0.0,
                ),
              ),
              tileColor: FlutterFlowTheme.of(context).secondaryBackground,
              activeColor: FlutterFlowTheme.of(context).primary,
              checkColor: FlutterFlowTheme.of(context).info,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          ),
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
            ),
            child: CheckboxListTile(
              value: _model.checkboxListTileValue2 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.checkboxListTileValue2 = newValue!);
              },
              title: Text(
                '15min',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  fontSize: 17.0,
                  letterSpacing: 0.0,
                ),
              ),
              tileColor: FlutterFlowTheme.of(context).secondaryBackground,
              activeColor: FlutterFlowTheme.of(context).primary,
              checkColor: FlutterFlowTheme.of(context).info,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          ),
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
            ),
            child: CheckboxListTile(
              value: _model.checkboxListTileValue3 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.checkboxListTileValue3 = newValue!);
              },
              title: Text(
                '30min',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  fontSize: 17.0,
                  letterSpacing: 0.0,
                ),
              ),
              tileColor: FlutterFlowTheme.of(context).secondaryBackground,
              activeColor: FlutterFlowTheme.of(context).primary,
              checkColor: FlutterFlowTheme.of(context).info,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          ),
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
            ),
            child: CheckboxListTile(
              value: _model.checkboxListTileValue4 ??= true,
              onChanged: (newValue) async {
                setState(() => _model.checkboxListTileValue4 = newValue!);
              },
              title: Text(
                '60min',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Outfit',
                  fontSize: 17.0,
                  letterSpacing: 0.0,
                ),
              ),
              tileColor: FlutterFlowTheme.of(context).secondaryBackground,
              activeColor: FlutterFlowTheme.of(context).primary,
              checkColor: FlutterFlowTheme.of(context).info,
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
            ),
          ),
        ],
      ),
    );
  }
}
