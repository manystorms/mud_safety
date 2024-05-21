import 'send_Alarm.dart';
import 'get_data.dart';

bool AlarmOn = true;
List<bool> AlarmSetting = [true, true, true, true, true];

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

  RemainingTime = drownTime-getUnixTime()-60*30;
  Data.AlertTime = drownTime;

  List<int> AlarmTime = [0, 5, 15, 30, 60]; //단위: 분

  if(AlarmOn == true) {
    cancelNotification();
    for(int i = 0; i < AlarmTime.length; i++) {
      if(AlarmSetting[i] == false) continue;

      showNotificationTimeSetting(
          '조석 경보',
          (AlarmTime[i] != 0)? '$i분 후에 갯벌에서 나가야 합니다':'지금 즉시 갯벌에서 나가야 합니다',
          RemainingTime-i*60,
      );
    }
  }
}