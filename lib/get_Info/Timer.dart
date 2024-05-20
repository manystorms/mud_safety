import 'send_Alarm.dart';
import 'get_data.dart';

void updateSettingTime() async {
  int? drownTime = null;
  int RemainingTime = 0;

  for(int i = 0; i < Data.obs_Graph_x.length; i++) {
    if(Data.Height <= Data.obs_Graph_y[i]/100) {
      drownTime = Data.obs_Graph_x[i];
      break;
    }
  }
  if(drownTime == null) drownTime = Data.obs_Graph_x.last;

  RemainingTime = drownTime-getUnixTime()-900;
  Data.AlertTime = drownTime-900;

  List<int> AlarmTime = [5, 15, 30, 60]; //단위: 분

  if(1 == 1) {
    cancelNotification();
    for(int i in AlarmTime) {
      showNotificationTimeSetting(
          '조석 경보',
          '$i분 후에 갯벌에서 나가야 합니다',
          RemainingTime-i*60,
      );
    }
  }
}