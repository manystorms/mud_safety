import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:mud_safety/get_Info/get_tide.dart';
import 'package:mud_safety/date/date_widget_Tide_card.dart';
import 'package:mud_safety/date/date_observatory_list.dart';
import 'date_model.dart';
export 'date_model.dart';
import 'package:mud_safety/warning_alarm/warning_alarm_widget.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> with TickerProviderStateMixin {
  late DateModel _model;
  Observatory_list observatory_list = Observatory_list();
  DateTimeRange _LastedSelectedDate = DateTimeRange(start: DateTime.now(), end: DateTime.now());
  String _ObsCode = 'DT_0001';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  MaximumMinimumTideData _TideData = MaximumMinimumTideData();

  Future<void> updateTide(DateTimeRange SelectedDate) async {
    _LastedSelectedDate = SelectedDate;

    TideReceive getTideData = TideReceive();
    _TideData = await getTideData.getMaximumMinimumTide(SelectedDate, _ObsCode);

    setState(() {});
  }

  void resetTideData() {
    _TideData.TideState = ['데이터를 받아오는 중'];
    _TideData.TideTime = ['--:--am'];
    _TideData.TideVal = ['xx(m)'];
  }

  Future<void> test() async{
    await Future.delayed(Duration(seconds: 3));
    print('a');

    showWarningAlarm(context, 'test');
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DateModel());
    resetTideData();
    //test();

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Text(
                    'Calendar',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              Container(
                width: 262.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child:Align(
                  alignment: AlignmentDirectional(0.9, 0.0),
                  child: FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController ??=
                        FormFieldController<String>(null),
                    options: observatory_list.name,
                    onChanged: (val) {
                      _ObsCode = observatory_list.getObsCode(val);
                      setState(() {
                        _model.dropDownValue = val;
                        updateTide(_LastedSelectedDate);
                      });
                    },
                    width: 124.0,
                    height: 56.0,
                    searchHintTextStyle:
                    FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                    ),
                    searchTextStyle:
                    FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0.0,
                    ),
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      letterSpacing: 0.0,
                    ),
                    hintText: '검색 위치',
                    searchHintText: '검색 위치',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 2.0,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderWidth: 2.0,
                    borderRadius: 8.0,
                    margin:
                    EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                    hidesUnderline: true,
                    isOverButton: true,
                    isSearchable: true,
                    isMultiSelect: false,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment(0, 0),
                    child: FlutterFlowButtonTabBar(
                      useToggleButtonStyle: true,
                      isScrollable: true,
                      labelStyle:
                      FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Plus Jakarta Sans',
                        letterSpacing: 0,
                      ),
                      unselectedLabelStyle: TextStyle(),
                      labelColor: FlutterFlowTheme.of(context).primaryText,
                      unselectedLabelColor:
                      FlutterFlowTheme.of(context).secondaryText,
                      backgroundColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                      unselectedBackgroundColor:
                      FlutterFlowTheme.of(context).alternate,
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderWidth: 2,
                      borderRadius: 12,
                      elevation: 0,
                      labelPadding:
                      EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      tabs: [
                        Tab(
                          text: 'Month',
                        ),
                        Tab(
                          text: 'Week',
                        ),
                      ],
                      controller: _model.tabBarController,
                      onTap: (i) async {
                        [() async {}, () async {}][i]();
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _model.tabBarController,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0,
                                          1,
                                        ),
                                      )
                                    ],
                                  ),
                                  child: FlutterFlowCalendar(
                                    color: FlutterFlowTheme.of(context).primary,
                                    iconColor: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    weekFormat: false,
                                    weekStartsMonday: true,
                                    onChange: (DateTimeRange? newSelectedDate) {
                                      setState(() {
                                        _model.calendarSelectedDay1 = newSelectedDate;
                                        resetTideData();
                                      });
                                      if(newSelectedDate != null) updateTide(newSelectedDate);
                                    },
                                    titleStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0,
                                    ),
                                    dayOfWeekStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0,
                                    ),
                                    dateStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0,
                                    ),
                                    selectedDateStyle:
                                    FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0,
                                    ),
                                    inactiveDateStyle:
                                    FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          for(int i = 0; i < _TideData.TideState.length; i++)
                                            if(_TideData.TideState[i] != '데이터를 받아오는 중')
                                              TideDataCard(TideData: _TideData, index: i),
                                          if(_TideData.TideState[0] == '데이터를 받아오는 중')
                                            GettingDataCard(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0,
                                          1,
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Builder(
                                    builder: (context) => FlutterFlowCalendar(
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      iconColor: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      weekFormat: true,
                                      weekStartsMonday: true,
                                      onChange: (DateTimeRange? newSelectedDate) {
                                        setState(() {
                                          _model.calendarSelectedDay1 = newSelectedDate;
                                          resetTideData();
                                        });
                                        if(newSelectedDate != null) updateTide(newSelectedDate);
                                      },
                                      titleStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                      dayOfWeekStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                      dateStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        letterSpacing: 0.0,
                                      ),
                                      selectedDateStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        letterSpacing: 0.0,
                                      ),
                                      inactiveDateStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          for(int i = 0; i < _TideData.TideState.length; i++)
                                            if(_TideData.TideState[i] != '데이터를 받아오는 중')
                                              TideDataCard(TideData: _TideData, index: i),
                                          if(_TideData.TideState[0] == '데이터를 받아오는 중')
                                            GettingDataCard(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
