import 'package:hive/hive.dart';
import 'package:stock_app/data/src/local/company_listing_entity.dart';

class CompanyListingEntityAdapter extends TypeAdapter<CompanyListingEntity> {
  @override
  final int typeId = 0;
  @override
  CompanyListingEntity read(BinaryReader r) {
    final n = r.readByte();
    final f = {for (var i = 0; i < n; i++) r.readByte(): r.read()};
    return CompanyListingEntity(
      symbol: f[0] as String,
      name: f[1] as String,
      exchange: f[2] as String,
    );
  }

  @override
  void write(BinaryWriter w, CompanyListingEntity o) {
    w
      ..writeByte(3)
      ..writeByte(0)
      ..write(o.symbol)
      ..writeByte(1)
      ..write(o.name)
      ..writeByte(2)
      ..write(o.exchange);
  }
}
