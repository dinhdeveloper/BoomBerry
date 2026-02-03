class Bank {
  final int id;
  final String name;
  final String code;
  final String bin;
  final String shortName;
  final String logo;
  final int transferSupported;
  final int lookupSupported;
  final int support;
  final int isTransfer;
  final String swiftCode;

  Bank({
    required this.id,
    required this.name,
    required this.code,
    required this.bin,
    required this.shortName,
    required this.logo,
    required this.transferSupported,
    required this.lookupSupported,
    required this.support,
    required this.isTransfer,
    required this.swiftCode,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      bin: json['bin'],
      shortName: json['shortName'] ?? json['short_name'],
      logo: json['logo'],
      transferSupported: json['transferSupported'] ?? 0,
      lookupSupported: json['lookupSupported'] ?? 0,
      support: json['support'] ?? 0,
      isTransfer: json['isTransfer'] ?? 0,
      swiftCode: json['swift_code'] ?? '',
    );
  }
}
