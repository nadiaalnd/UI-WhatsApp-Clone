import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({Key? key}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool isCameraReady = false;
  late Future<List<CameraDescription>> _cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCamPreview(),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Future<void> initCamera() async {
    _cameras = availableCameras();
    final cameras = await _cameras;
    await onNewCameraSelected(cameras.first);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      print('Camera error $e');
    }

    if (mounted) {
      setState(() {
        isCameraReady = true;
      });
    }
  }

  Widget _buildCamPreview() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return CameraPreview(controller!);
  }

  Widget _buildControlButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _customButton(
              'Take Photo',
              () async {
                try {
                  // make like blink
                  await controller!.setFlashMode(FlashMode.torch);
                  await Future.delayed(const Duration(milliseconds: 300));
                  await controller!.setFlashMode(FlashMode.off);
                  // take picture
                  final image = await controller!.takePicture();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        body: Center(
                          child: _displayImage(image.path),
                        ),
                      ),
                    ),
                  );
                } catch (e) {
                  print('Error taking picture: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(
      String text, Function() onPressed) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 241, 239, 239).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(35),
          onTap: onPressed,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  Widget _displayImage(String path) {
    return Image.file(
      File(path),
      fit: BoxFit.cover,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && controller != null) {
      onNewCameraSelected(controller!.description);
    }
  }
}
