import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mud_safety/get_Info/get_tide.dart';
import 'package:mud_safety/get_Info/send_Alarm.dart';
import 'package:share_plus/share_plus.dart';

class TideDataCard extends StatelessWidget {


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
                      '최대 조위',
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
                            color: FlutterFlowTheme.of(
                                context)
                                .accent3,
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
                                '2:20am',
                                style: FlutterFlowTheme.of(
                                    context)
                                    .bodyMedium
                                    .override(
                                  fontFamily:
                                  'Plus Jakarta Sans',
                                  color:
                                  FlutterFlowTheme.of(context).tertiary,
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
                          '10(m)',
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
                  Icons.arrow_upward,
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