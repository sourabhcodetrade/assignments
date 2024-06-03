class ApiResponseModel {
  final bool success;
  final dynamic result;
  final String message;

  ApiResponseModel( {required this.success, required this.result,required this.message});

  factory ApiResponseModel.fromResponse(Map<String, dynamic> responseData) {
    return ApiResponseModel(
      success: responseData["result"]["success"] ?? false,
      result: responseData["result"]["result"] ?? "",
      message: responseData["result"]["message"] ?? "Error",
    );
  }

  }
