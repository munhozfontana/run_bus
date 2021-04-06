import 'package:mockito/annotations.dart';
import 'package:run_bus/features/data/external/drivers/geocoding_adapter.dart';

@GenerateMocks([GeocodingAdapterHelper])
void main() {
  GeocodingAdapter(geocodingAdapterHelper: GeocodingAdapterHelper());
}
