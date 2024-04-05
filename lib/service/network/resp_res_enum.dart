import 'package:dio/dio.dart';
import 'package:easy_cse/constant/situation_enum.dart';

import '../../constant/app_string.dart';
import '../../domain/entity/code_desc.dart';

class ResultCode{
  // 前端自定义的状态码
  static const int USER_CANCELED = 8;
  static const int TIME_OUT = 9;
  static const int ERROR = 10;
  static const int DEBUG_ERROR = 11;
  static const int IMAGE_ERROR = 12;
  // 后端返回的状态码
  static const int SUCCESS = 0;

  static const int PASSWORD_NOT_MATCH = 1;
  static const int UNAUTHORIZED = 2;
  static const int AUTH_UPDATED = 3;

  static const int VERICODE_NOT_MATCH = 4;
  static const int VERICODE_FAILED = 5;

  static const int NOT_FOUND = 6;
  static const int SERVER_ERROR = 7;

  static final generalNetworkError=CodeDesc(SituationEnum.ERROR,AppStrings.somethingWentWrong,AppStrings.tryAgain);

  static final Map<int,CodeDesc>CodeDescs={
    SUCCESS: CodeDesc(SituationEnum.SUCCESS,AppStrings.success,AppStrings.finish),
    ERROR:CodeDesc(SituationEnum.ERROR,AppStrings.somethingWentWrong,AppStrings.notYourProblem),
    PASSWORD_NOT_MATCH:CodeDesc(SituationEnum.ERROR,AppStrings.passwordNotMatched,AppStrings.pleaseCheck),
    UNAUTHORIZED:CodeDesc(SituationEnum.ERROR,AppStrings.notSignIn,AppStrings.pleaseSignIn),
    VERICODE_NOT_MATCH:CodeDesc(SituationEnum.ERROR,AppStrings.veriCodeNotMatched,AppStrings.pleaseCheck),
    VERICODE_FAILED:CodeDesc(SituationEnum.ERROR,AppStrings.veriCodeFailed,AppStrings.tryAgain),
    AUTH_UPDATED:CodeDesc(SituationEnum.INFO,AppStrings.authUpDated,AppStrings.signInAgain),
    NOT_FOUND:CodeDesc(SituationEnum.ERROR,AppStrings.checkInput,AppStrings.checkInput),
    SERVER_ERROR:CodeDesc(SituationEnum.ERROR,AppStrings.serverError,AppStrings.tryLater),
    TIME_OUT:CodeDesc(SituationEnum.ERROR,AppStrings.poorNetwork,AppStrings.checkNetwork),

    // 客户端可能的错误
    DEBUG_ERROR:CodeDesc(SituationEnum.ERROR,AppStrings.debugError,''),
    USER_CANCELED:CodeDesc(SituationEnum.INFO,AppStrings.cancel,''),
    IMAGE_ERROR:CodeDesc(SituationEnum.ERROR,AppStrings.imageError,''),
  };
  static CodeDesc getDesc(int code){
    return CodeDescs[code]??CodeDesc(SituationEnum.ERROR,AppStrings.somethingWentWrong,AppStrings.tryAgain);
  }
}

bool isTimeOutException(DioException e){
  return e.type==DioExceptionType.sendTimeout||e.type==DioExceptionType.receiveTimeout||e.type==DioExceptionType.connectionTimeout;
}