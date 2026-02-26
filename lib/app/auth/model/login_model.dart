// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool success;
  int status;
  String accessToken;
  String tokenType;
  String expiresAt;
  User? user;
  String message;

  LoginModel({
    required this.success,
    required this.status,
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
    required this.user,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"] ?? false,
        status: json["status"] ?? 0,
        accessToken: json["token"] ?? "",
        tokenType: json["token_type"] ?? "",
        expiresAt: json["expires_at"] ?? "",
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt,
        "user": user?.toJson(),
        "message": message,
      };
}

class User {
  int id;
  String name;
  String username;
  String? email;
  String countryCode;
  String? mobileNumber;
  String? country;
  String currency;
  String? avatar;
  String? coverPhoto;
  int balance;
  String sellerType;
  String? companyName;
  String? yourDesignation;
  String? generalUserYourInterest;
  String? tradersSellType;
  String? tradersCategory;
  String? manufacturingServiceType;
  String? serviceProviderType;
  int isVerified;
  int skipProductModal;

  User({
    required this.id,
    required this.name,
    required this.username,
    this.email,
    required this.countryCode,
    this.mobileNumber,
    this.country,
    required this.currency,
    this.avatar,
    this.coverPhoto,
    required this.balance,
    required this.sellerType,
    this.companyName,
    this.yourDesignation,
    this.generalUserYourInterest,
    this.tradersSellType,
    this.tradersCategory,
    this.manufacturingServiceType,
    this.serviceProviderType,
    required this.isVerified,
    required this.skipProductModal,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        username: json["username"] ?? "",
        email: json["email"],
        countryCode: json["country_code"] ?? "",
        mobileNumber: json["mobile_number"],
        country: json["country"],
        currency: json["currency"] ?? "",
        avatar: json["avatar"],
        coverPhoto: json["cover_photo"],
        balance: json["balance"] ?? 0,
        sellerType: json["seller_type"] ?? "",
        companyName: json["company_name"],
        yourDesignation: json["your_designation"],
        generalUserYourInterest: json["general_user_your_interest"],
        tradersSellType: json["traders_sell_type"],
        tradersCategory: json["traders_category"],
        manufacturingServiceType: json["manufacturing_service_type"],
        serviceProviderType: json["service_provider_type"],
        isVerified: json["is_verified"] ?? 0,
        skipProductModal: json["skip_product_modal"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "country_code": countryCode,
        "mobile_number": mobileNumber,
        "country": country,
        "currency": currency,
        "avatar": avatar,
        "cover_photo": coverPhoto,
        "balance": balance,
        "seller_type": sellerType,
        "company_name": companyName,
        "your_designation": yourDesignation,
        "general_user_your_interest": generalUserYourInterest,
        "traders_sell_type": tradersSellType,
        "traders_category": tradersCategory,
        "manufacturing_service_type": manufacturingServiceType,
        "service_provider_type": serviceProviderType,
        "is_verified": isVerified,
        "skip_product_modal": skipProductModal,
      };
}
