import 'languages.dart';

class LanguageTh extends Languages {
  @override
  String get onBoardTitle1 =>
      "ภูมิแพ้แต่เราไม่แพ้";

  @override
  String get onBoardDescription1 =>
      "เป็นแอปพลิเคชันสำหรับประเมินอาการทางด้านโรคภูมิแพ้ จมูกและภูมิแพ้ตาในเด็กและผู้ใหญ่อายุ 12 ปีขึ้นไป โดยจะทำการประเมินอาการในทุกๆด้านของอาการภูมิแพ้ให้ผู้ป่วยทำการประเมินตัวเองในทุกวัน ทั้งอาการด้านจมูกและตาเป็นเวลา 1-4 สัปดาห์ และส่งมายังแพทย์ผู้ทำการรักษา";

  @override
  String get onBoardTitle2 =>
      "ประโยชน์";

  @override
  String get onBoardDescription2 =>
      "ทำให้แพทย์ผู้ดูแลสามารถประเมินอาการของภูมิแพ้จมูกและตาได้ ทำให้แพทย์สามารถปรับระดับการดูแลรักษาได้ ปรับการใช้ยาของผู้ป่วยได้อย่างเหมาะสม  สอดคล้องกับแนวทางการรักษาโรคภูมิแพ้ ในประเทศไทย ปี 2565 ซึ่งใช้เกณฑ์การประเมินความรุนแรงของโรคภูมิแพ้ โดยใช้ VAS (Visual Analog Scale) นอกจากนี้ยังเป็นไปตามแนวทาง ของการแพทย์ทางไกล (Telemedicine) อีกด้วย";

  @override
  String get onBoardTitle3 =>
      "ต่อยอด";

  @override
  String get onBoardDescription3 =>
      "หากมีฐานข้อมูล ที่ผู้ป่วยได้ทำการประเมินอาการของภูมิแพ้จมูกและตา มากเพียงพอ สามารถนำข้อมูลมาวิเคราะห์หาสาเหตุของโรค หรือการวิเคราะห์ในประเด็นที่สนใจได้ เพื่อนำข้อสรุปจากการวิเคราะห์ดังกล่าว มาเพื่อใช้เป็นประโยชน์สำหรับการรักษาโรคโดยภาพรวม";

  @override
  String get signIn => "เข้าสู่ระบบ";

  @override
  String get username => "ชื่อผู้ใช้งาน";

  @override
  String get password => "รหัสผ่าน";

  @override
  String get createAccount => "สร้างบัญชี";

  @override
  String get confirmPassword => "ยืนยันรหัสผ่าน";

  @override
  String get name => "ขื่อ";

  @override
  String get surname => "นามสกุล";

  @override
  String get dateOfBirth => "ว/ด/ป เกิด";

  @override
  String get gender => "เพศ";

  @override
  String get chooseGender => "กรุณาเลือกเพศ";

  @override
  String get privacyPolicy => "นโยบายความเป็นส่วนตัว";

  @override
  String get acceptConditions => "ยอมรับเงื่อนไข";

  @override
  String get usernameFieldEmpty => "ชื่อผู้ใช้งานว่างเปล่า";

  @override
  String get passwordFieldEmpty => "รหัสผ่านว่างเปล่า";

  @override
  String get confirmPasswordFieldEmpty => "ยืนยันรหัสผ่านว่างเปล่า";

  @override
  String get confirmPasswordNotMatch => "ยืนยันรหัสผ่านไม่ตรงกัน";

  @override
  String get nameFieldEmpty => "ชื่อว่างเปล่า";

  @override
  String get surnameFieldEmpty => "นามสกุลว่างเปล่า";

  @override
  String get dateOfBirthFieldEmpty => "ว/ด/ป เกิดว่างเปล่า";

  @override
  String get genderFieldEmpty => 'เพศว่างเปล่า';

  @override
  String get genderMale => 'ผู้ชาย';

  @override
  String get genderFemale => 'ผู้หญิง';

  @override
  String get usernameAlreadyExists => 'ชื่อผู้ใช้งานมีอยู่แล้ว';

  @override
  String get error => 'เกิดข้อผิดพลาด';

  @override
  String get ok => 'ตกลง';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get loading => 'กำลังโหลด...';

  @override
  String get createdSuccessfully => 'สร้างบัญชีสำเร็จ';

  @override
  String get usernameCannotBeEmpty => 'ชื่อผู้ใช้งานไม่สามารถว่างเปล่าได้';

  @override
  String get passwordCannotBeEmpty => 'รหัสผ่านไม่สามารถว่างเปล่าได้';

  @override
  String get usernameNotFound => 'ไม่พบชื่อผู้ใช้งาน';

  @override
  String get passwordNotMatch => 'รหัสผ่านไม่ตรงกัน';

  @override
  String get loginSuccess => 'เข้าสู่ระบบสำเร็จ';

  @override
  String get success => 'สำเร็จ';

  @override
  String get logout => 'ออกจากระบบ';

  @override
  String get logoutDescription => 'คุณต้องการออกจากระบบหรือไม่';

  @override
  String get questionStart => 'คำถามเริ่มต้น';

  @override
  String get questionDaily => 'คำถามประจำวัน';

  @override
  String get answerYes => 'ใช่';

  @override
  String get answerNo => 'ไม่';

  @override
  String get send => 'ส่งคำตอบ';

  @override
  String get uploadPhoto => 'อัพโหลดรูปภาพ';

  @override
  String get changePassword => 'เปลี่ยนรหัสผ่าน';

  @override
  String get oldPassword => 'รฟัสผ่านเดิม';

  @override
  String get newPassword => 'รหัสผ่านใหม่';

  @override
  String get confirmPassword2 => 'ยืนยันรหัสผ่านใหม่';

  @override
  String get oldPasswordNotMatch => 'รหัสผ่านเดิมไม่ตรงกัน';

  @override
  String get userNotFound => 'ไม่พบผู้ใช้งาน';

  @override
  String get deleteAccount => 'ลบบัญชี';

  @override
  String get deleteAccountDescription => 'คุณต้องการลบบัญชีหรือไม่';

  @override
  String get account => 'โปรไฟล์';

  @override
  String get question1 => 'อายุ';

  @override
  String get question2 => 'เพศ';

  @override
  String get question3 => 'ท่านมีอาการเหล่านี้หรือไม่';

  @override
  String get question3_1 => 'คัดจมูก';

  @override
  String get question3_2 => 'น้ำมูลไหล';

  @override
  String get question3_3 => 'จาม';

  @override
  String get question3_4 => 'คันจมูก';

  @override
  String get question3_5 => 'ไอเสมหะลงคอ';

  @override
  String get question3_6 => 'การได้กลิ่นลดลง';

  @override
  String get question3_7 => 'คันตา';

  @override
  String get question3_8 => 'ตาแดง';

  @override
  String get question3_9 => 'น้ำตาไหล';

  @override
  String get question3_10 => 'นอนกรนกดัง';

  @override
  String get question3_11 => 'หายใจหอบเหนื่อย';

  @override
  String get question3_12 => 'ไอช่วงกลางคืน';

  @override
  String get question3_13 => 'ไอขณะออกกำลังกาย';

  @override
  String get question3_14 => 'ผื่นแดงคัน';

  @override
  String get question3_15 => 'ผื่นบวมนูน ปื้นใหญ่';

  @override
  String get question3_16 => 'คันตามตัว';

  @override
  String get question4 => 'ท่านมีระยะเวลาของอาการเหล่านี้อย่างไร';

  @override
  String get question5 => 'อาการเหล่านี้รบกวนชีวิตประจำวันหรือไม่';

  @override
  String get question5_1 => 'การนอนหลับ';

  @override
  String get question5_2 => 'ออกกำลังกาย';

  @override
  String get question5_3 => 'การเรียน/การทำงาน';

  @override
  String get question5_4 => 'รบกวนคุณภาพชีวิต';

  @override
  String get question6 => 'สูบบุหรี่หรือไม่';

  @override
  String get question6_1 => 'ใกล้ชิดกับบุคคลที่สูบบุหรี่หรือไม่';

  @override
  String get question7 => 'มีสัตว์เลี้ยงหรือไม่';

  @override
  String get question7_1 => 'สัตว์ชนิดใดบ้าง';

  @override
  String get question7_1_1 => 'มีสัตว์อะไรบ้าง';

  @override
  String get question7_2 => 'สัตว์อยู่ในบ้านหรือไม่';

  @override
  String get question8 => 'ท่านมีโรคประจำตัวหรือไม่';

  @override
  String get question8_1 => 'โรคอะไร';

  @override
  String get question8_1_1 => 'บอกชื่อโรคประจำตัวของท่าน';

  @override
  String get question8_2 => 'มียาที่ต้องใช้ประจำหรือไม่';

  @override
  String get question8_3 => 'ชื่อยาหรือกลุ่มยา';

  @override
  String get question8_3_1 => 'ยาที่ท่านประจำวันทุกวัน';

  @override
  String get question9 => 'ท่านมีประวัติแพ้อาหารหรือไม่';

  @override
  String get question9_1 => 'อาหารและอาการ';

  @override
  String get question9_1_1 => 'ชื่ออาหารหรือประเภท รวมถึงอาการที่ได้รับ';

  @override
  String get question10 => 'ท่านมีประวัติแก้ยาหรือไม่';

  @override
  String get question10_1 => 'ยาและอาการ';

  @override
  String get question10_1_1 => 'ยาหรือกลุ่มยา อาการที่เป็น';

  @override
  String get question11 => 'ท่านเคยทดสอบภูมิแพ้หรือไม่';

  @override
  String get question11_1 => 'ทดสอบด้วยวิธีใด';

  @override
  String get question11_1_1 => 'แพ้อะไรบ้าง';

  @override
  String get dailyQuestion1 => 'อาการคัดจมูก';

  @override
  String get dailyQuestion1_1 => 'หายใจลางดี ไม่ติดขัด ถึง ขัดจมูกตลอดทั้งวันและทั้งคืน';

  @override
  String get dailyQuestion2 => 'น้ำมูกไหล';

  @override
  String get dailyQuestion2_1 => 'จมูกแห้งตลอดทั้งวัน ถึงมีน้ำมูกในจมูกตลอดเวลาในช่วงวัน ชั่วโมงของวัน';

  @override
  String get dailyQuestion3 => 'คันจมูก';

  @override
  String get dailyQuestion3_1 => 'ไม่คันจมูกเลย ถึง คันจมูกตลอดเวลา รบกวนชีวิตประจำวัน';

  @override
  String get dailyQuestion4 => 'จาม';

  @override
  String get dailyQuestion4_1 => 'ไม่จามเลย ถึง จามตลอดเวลา รบกวนชีวิตประจำวัน';

  @override
  String get dailyQuestion5 => 'ตาแดง';

  @override
  String get dailyQuestion5_1 => 'ไม่มีตาแดง ถึง ตาแดงสองข้าง';

  @override
  String get dailyQuestion6 => 'น้ำตาไหล';

  @override
  String get dailyQuestion6_1 => 'ไม่มีน้ำตาไหล ถึง มีน้ำตาไหลตลอด  รบกวนชีวิต';

  @override
  String get dailyQuestion7 => 'คันตา';

  @override
  String get dailyQuestion7_1 => 'ไม่คันเลย ถึง คันตาตลอดเลย รบกวนชีวิต';

  @override
  String get notificationPleaseAnswer => 'กรุณาตอบแบบสอบถาม';

  @override
  String get showMessagesConfirmationDailyQuestion => 'ยืนยันการส่งแบบสอบถาม';

  @override
  String get showMessagesConfirmationDailyQuestionDescription => 'คุณต้องการส่งแบบสอบถามใช่หรือไม่';

  @override
  String get dailySurvey => 'แบบสอบถามประจำวัน';

  @override
  String get preSurvey => 'แบบสอบถามก่อนเริ่มการรักษา';

  @override
  String get selectedUser => 'ทั้งหมด';

  @override
  String get filter => 'กรอง';

  @override
  String get selectedUserBack => 'เลือกผู้ใช้งาน';

  @override
  String get chooseLanguage => 'ภาษา';

  @override
  String get noseSickness => 'อาการทางจมูก ให้คะแนน 0-10 คะแนน';

  @override
  String get eyeSickness => 'อาการทางตา ให้คะแนน 0-10 คะแนน';

  @override
  String get petDogs => 'สนัข';

  @override
  String get petCats => 'แมว';

  @override
  String get petOther => 'อื่นๆ';

  @override
  String get bySkin => 'ทางผิวหนัง';

  @override
  String get byBlood => 'ทางเลือด';

  @override
  String get everyDay => 'ทุกวัน';

  @override
  String get everyWeek => 'มากกว่าหรือเท่ากับ 4 วันต่อสัปดาห์';

  @override
  String get someTime => 'น้อยกว่า 4 วันต่อสัปดาห์';

  @override
  String get pleaseAnswerAllQuestions => 'กรุณาตอบคำถามทุกข้อ';

  @override
  String get notifyTitle => 'คุณลืมหรือไม่?';

  @override
  String get notifyDescription => 'ถึงเวลาทำแบบสอบถามประจำวันแล้ว';

  @override
  String get headerSelectScreen => 'กรุณาเลือกรูปแบบแบบสอบถาม';

  @override
  String get btnSendDailyquestion => 'ส่งแบบสอบถาม';

  @override
  String get saveDailyquestion => 'บันทึก';

  @override
  String get totalScore => 'คะแนน';
}
