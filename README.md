Dự án này là một ứng dụng ghi chú đa nền tảng (Mobile & Desktop) được xây dựng bằng framework 
Flutter. Ứng dụng tập trung vào việc quản lý ghi chú cục bộ một cách hiệu quả, sử dụng Provider để 
quản lý trạng thái giao diện người dùng và SQFlite làm hệ thống cơ sở dữ liệu để lưu trữ dữ liệu bền 
vững trên thiết bị.

    Tính Năng Chính
Các tính năng chính của ứng dụng bao gồm:
Quản lý CRUD (Create, Read, Update, Delete) Ghi chú:
Tạo (Create): Cho phép người dùng tạo ghi chú mới với tiêu đề và nội dung bắt buộc.
Đọc (Read): Hiển thị danh sách tất cả các ghi chú đã lưu, được sắp xếp theo thời gian cập nhật giảm 
dần (updatedAt DESC).
Cập nhật (Update): Cho phép chỉnh sửa tiêu đề và nội dung của ghi chú hiện có. Thời gian cập nhật 
(updatedAt) sẽ được tự động làm mới khi lưu.
Xóa (Delete): Cho phép xóa một ghi chú sau khi xác nhận.
Lưu trữ Dữ liệu Bền vững: Sử dụng cơ sở dữ liệu SQLite thông qua package sqflite.
Quản lý Trạng thái: Sử dụng Provider (ChangeNotifierProvider và Consumer) để tách biệt logic quản 
lý dữ liệu và thông báo cập nhật tới giao diện người dùng.
Hỗ trợ Desktop: Cấu hình trong main.dart để sử dụng sqflite_common_ffi giúp ứng dụng có thể chạy và 
lưu trữ dữ liệu trên các nền tảng Desktop (Windows, Linux, macOS) ngoài Mobile.


    Cấu Trúc Dự Án: Flutter Note App
Dự án được tổ chức theo kiến trúc module hóa để tách biệt trách nhiệm (Separation of Concerns), 
giúp quản lý trạng thái, logic cơ sở dữ liệu và giao diện người dùng một cách rõ ràng.

1. Thư mục lib/models
   Chứa các lớp đại diện cho cấu trúc dữ liệu của ứng dụng.
note.dart: Định nghĩa Mô hình dữ liệu (Note).
Chứa các trường dữ liệu: id, title, content, createdAt, và updatedAt.
Cung cấp các phương thức tiện ích như toMap(), fromMap(), copyWith(), và constructor Note.newNote().

2. Thư mục lib/database
   Chứa lớp chịu trách nhiệm cho việc giao tiếp trực tiếp với cơ sở dữ liệu SQLite.
db_helper.dart: Lớp Trợ giúp Cơ sở dữ liệu Singleton (DatabaseHelper).
Xử lý việc khởi tạo cơ sở dữ liệu (_initDB) và tạo bảng (_createDB) với version: 2.
Chứa các phương thức CRUD cốt lõi: create, readAll, update, và delete.

3. Thư mục lib/providers
   Chứa các lớp quản lý trạng thái, làm cầu nối giữa giao diện người dùng và lớp cơ sở dữ liệu.
note_provider.dart: Lớp Quản lý Trạng thái (NoteProvider).
Kế thừa ChangeNotifier để thông báo cập nhật tới UI.
Quản lý danh sách ghi chú (List<Note> _notes).
Gọi các hàm của DatabaseHelper (như loadNotes(), addNote(), updateNote(), deleteNote()) và gọi 
notifyListeners() để cập nhật UI.

4. Thư mục lib/widgets
   Chứa các thành phần UI có thể tái sử dụng.
note_card.dart: Widget hiển thị tóm tắt của một ghi chú trong danh sách.
Bao gồm tiêu đề, nội dung ngắn gọn, thời gian cập nhật, và nút xóa.

5. Thư mục lib/screens
   Chứa các lớp đại diện cho các màn hình (pages) chính của ứng dụng.
home_page.dart: Màn hình Danh sách Ghi chú.
Sử dụng Consumer<NoteProvider> để hiển thị danh sách ghi chú bằng ListView.builder.
Chứa logic điều hướng đến màn hình chỉnh sửa và hộp thoại xác nhận xóa (_confirmDelete).
note_editor_screen.dart: Màn hình Tạo/Chỉnh sửa Ghi chú.
Chứa Form với TextFormField cho Tiêu đề và Nội dung.
Sử dụng Provider.of<NoteProvider>(context, listen: false) để gọi các hàm lưu/cập nhật ghi chú khi 
người dùng nhấn nút lưu.

6. File Gốc
   main.dart: Điểm Khởi đầu Ứng dụng.
Chứa logic khởi tạo sqflite_common_ffi để hỗ trợ cơ sở dữ liệu trên Desktop.
Khởi tạo ChangeNotifierProvider cho NoteProvider và gọi loadNotes() ngay khi ứng dụng bắt đầu.
Định nghĩa MyApp và MaterialApp (tắt debugShowCheckedModeBanner).

    Hướng Dẫn Chạy Ứng Dụng
Để chạy ứng dụng Flutter Note App,  cần đảm bảo môi trường phát triển Flutter đã được cài đặt và
cấu hình đúng.

1. Yêu cầu Tiên quyết
   Flutter SDK và Dart SDK (phiên bản ổn định).
Đã tải về hoặc clone mã nguồn dự án.
Các dependencies cần thiết (như provider, sqflite, sqflite_common_ffi, intl,...) đã được thêm vào 
file pubspec.yaml.

2. Chuẩn bị Môi trường
   Mở Terminal hoặc Command Prompt: Điều hướng đến thư mục gốc của dự án của  (nơi chứa thư mục lib).
Tải Dependencies: Chạy lệnh sau để tải tất cả các gói cần thiết:
Logic khởi tạo được đặt trong hàm main():
không cần chỉnh sửa gì, chỉ cần đảm bảo đoạn code này tồn tại để cho phép ứng dụng hoạt động với 
cơ sở dữ liệu cục bộ .

    Chạy Ứng dụng
 có thể chạy ứng dụng trên nhiều nền tảng:
A. Chạy trên Thiết bị Di động hoặc Emulator/Simulator
Đảm bảo  đã kết nối một thiết bị di động hoặc đã khởi động một AVD/Simulator.
Kiểm tra thiết bị đang hoạt động:
Chạy ứng dụng:
(Flutter sẽ chọn thiết bị đang kết nối hoặc emulator đang chạy).

Thao tác Cơ bản
   Sau khi ứng dụng khởi chạy thành công,  có thể thực hiện các thao tác sau:
Thêm Ghi chú: Nhấn vào nút Floating Action Button (FAB) có biểu tượng + để mở màn hình chỉnh sửa.
Lưu Ghi chú: Trên màn hình chỉnh sửa, điền Tiêu đề và Nội dung, sau đó nhấn biểu tượng Lưu (Save) ở 
AppBar.
Chỉnh sửa Ghi chú: Nhấn vào bất kỳ NoteCard nào trong danh sách để mở màn hình chỉnh sửa 
(NoteEditorScreen) với dữ liệu hiện có.
Xóa Ghi chú: Nhấn vào biểu tượng Thùng rác trên NoteCard. Một hộp thoại xác nhận (_confirmDelete) 
sẽ hiện ra trước khi xóa ghi chú khỏi cơ sở dữ liệu.