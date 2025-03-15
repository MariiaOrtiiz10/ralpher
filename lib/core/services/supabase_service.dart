import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService{

  Future <void> initialize() async{
    await Supabase.initialize(
      url: "https://xvkymhtcipdbdanikzpq.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2a3ltaHRjaXBkYmRhbmlrenBxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4NTU1MjksImV4cCI6MjA0OTQzMTUyOX0.sYVHSRdm1cEv4Vydp2lsmngmD3aBG-bBOW61raBnhe4",
      //Opciones de autenticación
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
      ),
    );
  }
}
