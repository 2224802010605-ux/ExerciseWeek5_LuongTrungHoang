import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/note_provider.dart';
import 'screens/home_page.dart';

// Import cần thiết cho việc khắc phục lỗi DB trên Desktop
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // BẮT BUỘC: Đảm bảo Flutter bindings được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // KIỂM TRA VÀ KHỞI TẠO CHO NỀN TẢNG DESKTOP (Windows/Linux/macOS)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider()..loadNotes(),
      child: MaterialApp(
        title: 'Flutter Note App',

        // SỬA: Ẩn nhãn "DEBUG" ở góc trên bên phải
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}