import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:growwth/camera_screen.dart';

class NewPlantForm extends StatefulWidget {
  const NewPlantForm({Key? key}) : super(key: key);

  @override
  State<NewPlantForm> createState() => _NewPlantFormState();
}

class _NewPlantFormState extends State<NewPlantForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmitButton(context) async {
    if (_formKey.currentState!.validate()) {
      WidgetsFlutterBinding.ensureInitialized();

      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      final firstCamera = cameras.first;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(
            camera: firstCamera,
            plantName: _nameController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell us about your plant'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Bobby',
                  helperText: 'Give your plant a name.',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                minLines: 2,
                maxLines: 4,
                maxLength: 150,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add some extra notes...',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  _handleSubmitButton(context);
                },
                style: ElevatedButton.styleFrom(
                  // Foreground color
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  // Background color
                  primary: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size.fromHeight(50),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                child: const Text('Take the first picture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
