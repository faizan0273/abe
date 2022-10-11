import 'dart:io';
import 'package:abe/utils/file_utils.dart';
import 'package:abe/utils/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

abstract class Service {

  //function to upload images to firebase storage and retrieve the url.
  Future<String> uploadImage(Reference ref, File file) async {
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("${uuid.v4()}.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => {
    });
    String fileUrl = await storageReference.getDownloadURL();
    print(fileUrl);
    return fileUrl;
  }
}
