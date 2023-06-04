import 'package:allergic_app/views/choose_languate.dart';
import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get onBoardTitle1;

  String get onBoardDescription1;

  String get onBoardTitle2;

  String get onBoardDescription2;

  String get onBoardTitle3;

  String get onBoardDescription3;

  String get signIn;

  String get username;

  String get password;

  String get createAccount;

  String get confirmPassword;

  String get name;

  String get surname;

  String get dateOfBirth;

  String get gender;

  String get chooseGender;

  String get privacyPolicy;

  String get acceptConditions;

  String get usernameFieldEmpty;

  String get passwordFieldEmpty;

  String get confirmPasswordFieldEmpty;

  String get confirmPasswordNotMatch;

  String get nameFieldEmpty;

  String get surnameFieldEmpty;

  String get dateOfBirthFieldEmpty;

  String get genderFieldEmpty;

  String get genderMale;

  String get genderFemale;

  String get usernameAlreadyExists;

  String get error;

  String get ok;

  String get cancel;

  String get loading;

  String get createdSuccessfully;

  String get usernameCannotBeEmpty;

  String get passwordCannotBeEmpty;

  String get usernameNotFound;

  String get passwordNotMatch;

  String get loginSuccess;

  String get success;

  String get logout;

  String get logoutDescription;

  String get questionStart;

  String get questionDaily;

  String get answerYes;

  String get answerNo;

  String get send;

  String get uploadPhoto;

  String get changePassword;

  String get oldPassword;

  String get newPassword;

  String get confirmPassword2;

  String get oldPasswordNotMatch;

  String get userNotFound;

  String get deleteAccount;

  String get deleteAccountDescription;

  String get account;

  String get question1;

  String get question2;

  String get question3;

  String get question3_1;

  String get question3_2;

  String get question3_3;

  String get question3_4;

  String get question3_5;

  String get question3_6;

  String get question3_7;

  String get question3_8;

  String get question3_9;

  String get question3_10;

  String get question3_11;

  String get question3_12;

  String get question3_13;

  String get question3_14;

  String get question3_15;

  String get question3_16;

  String get question4;

  String get question5;

  String get question5_1;

  String get question5_2;

  String get question5_3;

  String get question5_4;

  String get question6;

  String get question6_1;

  String get question7;

  String get question7_1;

  String get question7_1_1;

  String get question7_2;

  String get question8;

  String get question8_1;

  String get question8_1_1;

  String get question8_2;

  String get question8_3;

  String get question8_3_1;

  String get question9;

  String get question9_1;

  String get question9_1_1;

  String get question10;

  String get question10_1;

  String get question10_1_1;

  String get question11;

  String get question11_1;

  String get question11_1_1;

  String get dailyQuestion1;

  String get dailyQuestion1_1;

  String get dailyQuestion2;

  String get dailyQuestion2_1;

  String get dailyQuestion3;

  String get dailyQuestion3_1;

  String get dailyQuestion4;

  String get dailyQuestion4_1;

  String get dailyQuestion5;

  String get dailyQuestion5_1;

  String get dailyQuestion6;

  String get dailyQuestion6_1;

  String get dailyQuestion7;

  String get dailyQuestion7_1;

  String get notificationPleaseAnswer;

  String get showMessagesConfirmationDailyQuestion;

  String get showMessagesConfirmationDailyQuestionDescription;

  String get dailySurvey;

  String get preSurvey;

  String get selectedUser;

  String get filter;

  String get selectedUserBack;

  String get chooseLanguage;

  String get noseSickness;

  String get eyeSickness;

  String get petDogs;

  String get petCats;

  String get petOther;

  String get bySkin;

  String get byBlood;

  String get everyDay;

  String get everyWeek;

  String get someTime;

  String get pleaseAnswerAllQuestions;

  String get notifyTitle;

  String get notifyDescription;
}
