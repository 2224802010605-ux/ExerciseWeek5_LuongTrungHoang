// Code không đổi so với phiên bản cuối cùng (sử dụng Consumer)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../screens/note_editor_screen.dart';
import '../widgets/note_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          if (noteProvider.notes.isEmpty) {
            return const Center(
              child: Text('No notes yet! Tap + to add one.', style: TextStyle(fontSize: 16)),
            );
          }

          return ListView.builder(
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              final note = noteProvider.notes[index];
              return NoteCard(
                note: note,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => NoteEditorScreen(note: note),
                    ),
                  );
                },
                onDelete: () => _confirmDelete(context, note.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const NoteEditorScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  // ... (Hàm _confirmDelete)
  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Provider.of<NoteProvider>(context, listen: false).deleteNote(id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}