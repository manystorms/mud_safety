import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mud_safety/get_Info/Timer.dart';

import 'warning_alarm_model.dart';
export 'warning_alarm_model.dart';

void TimeCheck(BuildContext context, int RemainTime) {
  for(int i = 0; i < AlarmTime.length; i++) {
    if(RemainTime == AlarmTime[i]*60 && AlarmOn == true && AlarmSetting[i] == true) {
      String Content = 'a';
      if(AlarmTime[i] == 0) Content = '지금 즉시 갯벌에서 나가야 해요!';
      else Content = '${AlarmTime[i]}분 후에 갯벌에서 나가야 해요!';

      showWarningAlarm(context, Content);
      break;
    }
  }
}

Future<void> showWarningAlarm(BuildContext context, String Content) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false,
    context: context,
    builder: (context) {
      return Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: WarningAlarmWidget(
          Content: Content,
        ),
      );
    },
  );
}

class WarningAlarmWidget extends StatefulWidget {
  //const WarningAlarmWidget({super.key});

  String Content = 'a';
  WarningAlarmWidget({required this.Content});

  @override
  State<WarningAlarmWidget> createState() => _WarningAlarmWidgetState();
}

class _WarningAlarmWidgetState extends State<WarningAlarmWidget> {
  late WarningAlarmModel _model;
  int _ImageNum = 3;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WarningAlarmModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 370,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                  child: Text(
                    widget.Content,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 40,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                      'assets/images/Image${_ImageNum.toString()}.png',
                      height: 150,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pop();
                      },
                      text: '닫기',
                      options: FFButtonOptions(
                        width: 270,
                        height: 50,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.white,
                          letterSpacing: 0,
                        ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
