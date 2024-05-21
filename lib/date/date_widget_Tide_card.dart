import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:mud_safety/get_Info/get_tide.dart';

class TideDataCard extends StatelessWidget {
  MaximumMinimumTideData TideData = MaximumMinimumTideData();
  int index = 0;

  TideDataCard({required this.TideData, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsetsDirectional.fromSTEB(
          16, 0, 16, 12),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color:
          FlutterFlowTheme.of(context)
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
          borderRadius:
          BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize:
            MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
            children: [
              Column(
                mainAxisSize:
                MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional
                        .fromSTEB(4,
                        0, 0, 0),
                    child: Text(
                      TideData.TideState[index],
                      style: FlutterFlowTheme
                          .of(context)
                          .headlineSmall
                          .override(
                        fontFamily:
                        'Outfit',
                        letterSpacing:
                        0,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsetsDirectional
                        .fromSTEB(0,
                        4, 0, 0),
                    child: Row(
                      mainAxisSize:
                      MainAxisSize
                          .max,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional
                              .fromSTEB(
                              0,
                              0,
                              8,
                              0),
                          child: Card(
                            clipBehavior:
                            Clip.antiAliasWithSaveLayer,
                            color: TideData.TideState[index] == '최대 조위' ? FlutterFlowTheme.of(context).accent3:FlutterFlowTheme.of(context).accent1,
                            elevation: 0,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(8),
                            ),
                            child:
                            Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(
                                  8,
                                  4,
                                  8,
                                  4),
                              child: Text(
                                TideData.TideTime[index],
                                style: FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'Plus Jakarta Sans',
                                  color:
                                  TideData.TideState[index] == '최대 조위' ? FlutterFlowTheme.of(context).tertiary : FlutterFlowTheme.of(context).primary,
                                  fontSize:
                                  17,
                                  letterSpacing:
                                  0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          TideData.TideVal[index],
                          style: FlutterFlowTheme.of(
                              context)
                              .bodySmall
                              .override(
                            fontFamily:
                            'Plus Jakarta Sans',
                            fontSize:
                            15,
                            letterSpacing:
                            0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme
                      .of(context)
                      .primaryBackground,
                  borderRadius:
                  BorderRadius
                      .circular(8),
                  shape:
                  BoxShape.rectangle,
                  border: Border.all(
                    color: FlutterFlowTheme
                        .of(context)
                        .alternate,
                    width: 1,
                  ),
                ),
                alignment:
                AlignmentDirectional(
                    0, 0),
                child: Icon(
                  TideData.TideState[index] == '최대 조위' ? Icons.arrow_upward : Icons.arrow_downward,
                  color:
                  FlutterFlowTheme.of(
                      context)
                      .primaryText,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GettingDataCard extends StatefulWidget {
  @override
  _GettingDataCardState createState() => _GettingDataCardState();
}

class _GettingDataCardState extends State<GettingDataCard> {
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(-50.0, 0.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsetsDirectional.fromSTEB(
          16, 0, 16, 12),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color:
          FlutterFlowTheme.of(context)
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
          borderRadius:
          BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize:
            MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
            children: [
              Column(
                mainAxisSize:
                MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Padding(
                    padding:
                    EdgeInsetsDirectional
                        .fromSTEB(4,
                        0, 0, 0),
                    child: Text(
                      '데이터를 받아오는 중',
                      style: FlutterFlowTheme
                          .of(context)
                          .headlineSmall
                          .override(
                        fontFamily:
                        'Outfit',
                        letterSpacing:
                        0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme
                      .of(context)
                      .primaryBackground,
                  borderRadius:
                  BorderRadius
                      .circular(8),
                  shape:
                  BoxShape.rectangle,
                  border: Border.all(
                    color: FlutterFlowTheme
                        .of(context)
                        .alternate,
                    width: 1,
                  ),
                ),
                alignment:
                AlignmentDirectional(
                    0, 0),
                child: Icon(
                  Icons.back_hand_outlined,
                  color:
                  FlutterFlowTheme.of(
                      context)
                      .primaryText,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ).animateOnPageLoad(animationsMap[
        'containerOnPageLoadAnimation'
      ]!),
    );
  }
}