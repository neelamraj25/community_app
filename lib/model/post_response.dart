class PostResponse {
  final int? success;
  final String? message;
  final List<Post>? data;

  PostResponse({this.success, this.message, this.data});

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        success: json['success'] as int?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class Post {
  final String? id;
  final User? userId;
  final String? postMessage;
  final String? type;
  final String? postType;
  final String? title;
  final int? postShareCount;
  final int? viewCount;
  final int? likeCount;
  final int? commentCount;
  final bool? isVerified;
  final bool? isDeleted;
  final List<ImageData>? image;
  final List<ImageBase>? imageBase;
  final String? icon;
  final String? video;
  final String? createdAt;
  final String? updatedAt;
  final String? url;
  final int? v;
  final bool? isLiked;

  Post({
    this.id,
    this.userId,
    this.postMessage,
    this.type,
    this.postType,
    this.title,
    this.postShareCount,
    this.viewCount,
    this.likeCount,
    this.commentCount,
    this.isVerified,
    this.isDeleted,
    this.image,
    this.imageBase,
    this.icon,
    this.video,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.v,
    this.isLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['_id'] as String?,
        userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
        postMessage: json['post_message'] as String?,
        type: json['type'] as String?,
        postType: json['post_type'] as String?,
        title: json['title'] as String?,
        postShareCount: json['post_share_count'] as int?,
        viewCount: json['view_count'] as int?,
        likeCount: json['like_count'] as int?,
        commentCount: json['comment_count'] as int?,
        isVerified: json['is_verified'] as bool?,
        isDeleted: json['is_deleted'] as bool?,
        image: (json['image'] as List<dynamic>?)
            ?.map((e) => ImageData.fromJson(e as Map<String, dynamic>))
            .toList(),
        imageBase: (json['image_base'] as List<dynamic>?)
            ?.map((e) => ImageBase.fromJson(e as Map<String, dynamic>))
            .toList(),
        icon: json['icon'] as String?,
        video: json['video'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        url: json['url'] as String?,
        v: json['__v'] as int?,
        isLiked: json['isLiked'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId?.toJson(),
        'post_message': postMessage,
        'type': type,
        'post_type': postType,
        'title': title,
        'post_share_count': postShareCount,
        'view_count': viewCount,
        'like_count': likeCount,
        'comment_count': commentCount,
        'is_verified': isVerified,
        'is_deleted': isDeleted,
        'image': image?.map((e) => e.toJson()).toList(),
        'image_base': imageBase?.map((e) => e.toJson()).toList(),
        'icon': icon,
        'video': video,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'url': url,
        '__v': v,
        'isLiked': isLiked,
      };
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? password;
  final String? type;
  final String? status;
  final int? dailyScore;
  final bool? goldCoinReceived;
  final bool? goldQualify;
  final bool? silverCoinReceived;
  final bool? silverQualify;
  final int? totalScore;

  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.type,
    this.status,
    this.dailyScore,
    this.goldCoinReceived,
    this.goldQualify,
    this.silverCoinReceived,
    this.silverQualify,
    this.totalScore,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        mobile: json['mobile'] as String?,
        password: json['password'] as String?,
        type: json['type'] as String?,
        status: json['status'] as String?,
        dailyScore: json['daily_score'] as int?,
        goldCoinReceived: json['gold_coin_recieved'] as bool?,
        goldQualify: json['gold_qualify'] as bool?,
        silverCoinReceived: json['silver_coin_recieved'] as bool?,
        silverQualify: json['silver_qualify'] as bool?,
        totalScore: json['total_score'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'password': password,
        'type': type,
        'status': status,
        'daily_score': dailyScore,
        'gold_coin_recieved': goldCoinReceived,
        'gold_qualify': goldQualify,
        'silver_coin_recieved': silverCoinReceived,
        'silver_qualify': silverQualify,
        'total_score': totalScore,
      };
}

class ImageData {
  final String? img;

  ImageData({this.img});

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        img: json['img'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'img': img,
      };
}

class ImageBase {
  final String? location;
  final String? originalname;

  ImageBase({this.location, this.originalname});

  factory ImageBase.fromJson(Map<String, dynamic> json) => ImageBase(
        location: json['location'] as String?,
        originalname: json['originalname'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'location': location,
        'originalname': originalname,
      };
}
