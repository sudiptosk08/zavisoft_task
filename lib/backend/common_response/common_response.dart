import 'dart:convert';

CommonResponse errorResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String errorResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({this.status, required this.message});

  /// Human‑readable error or info message from the backend.
  ///
  /// Kept non-null; when the API does not provide a "message" field we
  /// gracefully default to an empty string to avoid type errors.
  final String message;
  final bool? status;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    message: (json["message"] ?? '').toString(),
    status: json["status"] as bool?,
  );

  Map<String, dynamic> toJson() => {"message": message, "status": status};
}
