// response_model.dart

class ResponseModel<T> {
  /// Indicates whether the operation was successful.
  /// Defaults to false unless proven otherwise in fromJson().
  bool success;

  /// Any message returned by the API (e.g. "Company details retrieved successfully.").
  String? message;

  /// The actual payload—e.g. a T object (CompanyRead, UserRead, etc.) or null.
  T? object;

  ResponseModel({
    this.message,
    bool? success, 
    this.object,
  }) : success = success ?? false; 

  /// Factory: build a ResponseModel<T> from JSON.
  /// 
  /// - If JSON contains `"success": <bool>`, use that.  
  /// - **Otherwise**, if `"data"` exists and is non-null, treat success = true.  
  /// - If `"object"` is present instead of `"data"` (legacy), do not override it here.
  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    // 1) Read `success` if the server explicitly set it:
    final bool explicitSuccess = json['success'] as bool? ?? false;

    // 2) Pull out `message` (may be missing, so nullable):
    final String? msg = json['message'] as String?;

    // 3) Derive `object` either from "object" or from "data":
    T? parsedObject;
    if (json.containsKey('object') && json['object'] != null && fromJsonT != null) {
      parsedObject = fromJsonT(json['object']);
    } else if (json.containsKey('data') && json['data'] != null && fromJsonT != null) {
      parsedObject = fromJsonT(json['data']);
    }

    // 4) Decide final `success`:
    //    - If the JSON explicitly had `"success"`, use it.
    //    - Else if we see a non-null `data`, assume success = true.
    //    - Otherwise, leave it false.
    final bool finalSuccess = explicitSuccess || (parsedObject != null);

    return ResponseModel<T>(
      success: finalSuccess,
      message: msg,
      object: parsedObject,
    );
  }

  /// Convert back to JSON if needed (includes `success`, `message`, and `object`).
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T? obj)? toJsonT) {
    return {
      'success': success,
      'message': message,
      'object': object != null && toJsonT != null ? toJsonT(object) : object,
    };
  }
}


// generic_response.dart

class GenericResponseModel<T> {
  final String message;
  final T? data;

  GenericResponseModel({
    required this.message,
    this.data,
  });

  // fromJson: the API always returns { "message": "...", "data": { ... } }
  factory GenericResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return GenericResponseModel(
      message: json['message'] as String,
      data: json['data'] != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}