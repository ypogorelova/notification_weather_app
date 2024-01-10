class LocationKey {
  String? key;

  LocationKey({this.key});

  factory LocationKey.fromJson(Map<String, dynamic> json) => LocationKey(
        key: json['Key'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'key': key,
      };
}
