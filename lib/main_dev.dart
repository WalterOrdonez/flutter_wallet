import 'package:bam_wallet_transfers/core/environment/env.dart';
import 'package:bam_wallet_transfers/main.dart';

void main(List<String> args) {
  Env.env = Environment.dev;
  runProject();
}
