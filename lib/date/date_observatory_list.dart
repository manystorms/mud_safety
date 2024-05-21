

class Observatory_list {
  String getObsCode(String? ObsName) {
    if(ObsName == Null) return 'DT_0001';
    for(int i = 0; i < name.length; i++) {
      if(name[i] == ObsName) return ObsCode[i];
    }
    return 'DT_0001';
  }

  List<String> name = [
    '남애항',
    '강릉항',
    '궁촌항',
    '죽변항',
    '축산항',
    '강구항',
    '서망항',
    '진해',
    '도장항',
    '보옥항',
    '천리포항',
    '승봉도',
    '양포항',
    '강양항',
    '거제외포',
    '소매물도',
    '쉬미항',
    '화봉리',
    '국화도',
    '울도',
    '청산도',
    '안도항',
    '능양항',
    '홍도항',
    '진도옥도',
    '땅끝항',
    '소안항',
    '독도',
    '평택',
    '영광',
    '제주',
    '부산',
    '묵호',
    '목포',
    '안산',
    '서귀포',
    '후포',
    '속초',
    '울릉도',
    '여수',
    '대산',
    '군산',
    '추자도',
    '모슬포',
    '진도',
    '강화대교',
    '대청도',
    '해운대',
    '호산항',
    '울산',
    '성산포',
    '장항',
    '고흥발포',
    '완도',
    '거제도',
    '거문도',
    '흑산도',
    '영종대교',
    '도농탄',
    '태안',
    '속초등표',
    '서천마량',
    '초도',
    '광양',
    '부산항신항',
    '동해항',
    '안마도',
    '강화외포',
    '경인항',
    '영종왕산',
    '미조항',
    '이어도',
    '굴업도',
    '보령',
    '인천',
    '인천송도',
    '통영',
    '어청도',
    '쌍정초',
    '왕돌초',
    '복사초',
    '교본초',
    '영흥도',
    '삼천포',
    '벽파진',
    '덕적도',
    '말도',
    '나로도',
    '마량항',
    '시산항',
    '두문포',
    '봉우항',
    '창선도',
    '호도',
    '백령도',
    '연평도',
    '여서도',
    '고현항',
    '옹진소청초',
    '신안가거초',
    '서거차도',
    '우이도',
    '읍천항',
    '남포항',
    '광암항',
    '백야도',
    '가거도',
    '송공항',
    '향화도항',
    '백사장항',
    '대진항',
    '낙월도',
    '외연도항',
    '안남리',
    '원동항',
    '평호리',
     '어류정항',
     '교동대교',
     '독거도',
     '평도',
     '상왕등도',
     '만재도',
     '신안옥도',
     '장문리',
     '위도',
     '오산항',
     '하의도웅곡',
     '암태도',
     '검산항',
     '녹동항',
     '안흥',
     '포항',
     '상태도',
     '달천도',
     '사초항',
     '가덕도',
     '마산',
     '강화하리',
     '여호항',
     '잠진도',
     '자월도',
     '방포항',
     '무창포항',
     '격포항',
     '구시포항',
     '계마항',
     '송이도',
     '남열항',
     '구룡포항',
     '궁평항',
     '삼길포항',
     '어은돌항',
     '연도항',
     '다대포항',
     '화순항',
     '거진항',
     '공현진항',
     '아야진항',
     '장호항',
     '사천진항'
  ];

  List<String> ObsCode = [
    'SO_0732',
    'SO_0733',
    'SO_0734',
    'SO_0735',
    'SO_0736',
    'SO_0737',
    'SO_0555',
    'DT_0054',
    'SO_0739',
    'SO_0740',
    'SO_0699',
    'SO_0562',
    'SO_0573',
    'SO_0581',
    'SO_0571',
    'SO_0578',
    'SO_0567',
    'SO_0576',
    'SO_0564',
    'SO_0563',
    'SO_0706',
    'SO_0708',
    'SO_0712',
    'SO_0701',
    'SO_0702',
    'SO_0703',
    'SO_0704',
    'DT_0040',
    'DT_0002',
    'DT_0003',
    'DT_0004',
    'DT_0005',
    'DT_0006',
    'DT_0007',
    'DT_0008',
    'DT_0010',
    'DT_0011',
    'DT_0012',
    'DT_0013',
    'DT_0016',
    'DT_0017',
    'DT_0018',
    'DT_0021',
    'DT_0023',
    'DT_0028',
    'DT_0032',
    'DT_0036',
    'SO_0553',
    'SO_0540',
    'DT_0020',
    'DT_0022',
    'DT_0024',
    'DT_0026',
    'DT_0027',
    'DT_0029',
    'DT_0031',
    'DT_0035',
    'DT_0044',
    'DT_0047',
    'DT_0050',
    'DT_0048',
    'DT_0051',
    'SO_0549',
    'DT_0049',
    'DT_0056',
    'DT_0057',
    'SO_0538',
    'SO_0539',
    'DT_0058',
    'SO_0554',
    'SO_0326',
    'IE_0060',
    'DT_0038',
    'DT_0025',
    'DT_0001',
    'DT_0052',
    'DT_0014',
    'DT_0037',
    'DT_0046',
    'DT_0039',
    'DT_0041',
    'DT_0042',
    'DT_0043',
    'DT_0061',
    'SO_0537',
    'SO_0536',
    'SO_0547',
    'SO_0550',
    'SO_0705',
    'SO_0707',
    'SO_0709',
    'SO_0710',
    'SO_0711',
    'SO_0700',
    'DT_0059',
    'DT_0060',
    'SO_0551',
    'SO_0552',
    'IE_0062',
    'IE_0061',
    'SO_0543',
    'SO_0548',
    'SO_0572',
    'SO_0569',
    'SO_0570',
    'SO_0568',
    'SO_0577',
    'SO_0566',
    'SO_0565',
    'SO_0574',
    'SO_0731',
    'SO_1251',
    'SO_1252',
    'SO_0757',
    'SO_0755',
    'SO_0754',
    'SO_1256',
    'DT_0064',
    'SO_1249',
    'SO_1250',
    'SO_1253',
    'SO_1254',
    'SO_1248',
    'SO_0759',
    'DT_0068',
    'SO_0760',
    'SO_0753',
    'SO_0631',
    'SO_0752',
    'SO_0761',
    'DT_0067',
    'DT_0091',
    'SO_1255',
    'SO_0758',
    'SO_0756',
    'DT_0063',
    'DT_0062',
    'SO_1257',
    'DT_0092',
    'SO_1258',
    'SO_1259',
    'SO_1260',
    'SO_1261',
    'SO_1262',
    'SO_1263',
    'SO_1264',
    'SO_1265',
    'SO_1266',
    'SO_1267',
    'SO_1268',
    'SO_1270',
    'SO_1271',
    'SO_1269',
    'SO_1272',
    'SO_1277',
    'SO_1274',
    'SO_1275',
    'SO_1276',
    'SO_1273',
    'SO_1278'
  ];
}