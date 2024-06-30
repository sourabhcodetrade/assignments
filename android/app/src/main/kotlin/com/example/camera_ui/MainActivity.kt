package com.example.camera_ui


import android.annotation.SuppressLint
import android.content.Intent
import android.os.Environment
import android.provider.MediaStore
import android.view.WindowManager.LayoutParams
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.Date


class MainActivity : FlutterActivity() {
    private val channel = "channel"
    private val cameraRequest = 1234
    private var myResult: MethodChannel.Result? = null
    private var photoFile: File? = null
    private var mCurrentPhotoPath: String? = null


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if (call.method == "cameraOn") {
                myResult = result
                openCamera()

            }
            else {
                result.notImplemented()
            }
        }
    }

    private  fun openCamera(){
        try {
            val cameraIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
            photoFile = createImageFile()
            val photoURI = FileProvider.getUriForFile(
                this,
                "com.example.camera_ui.flutter.image_provider",
                photoFile!!
            )
            cameraIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI)
            startActivityForResult(cameraIntent, cameraRequest)
        }catch (e:Exception){
            println("Kotlin Error $e")
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == cameraRequest && resultCode == RESULT_OK) {
            myResult?.success(mCurrentPhotoPath)
        }
    }


    @SuppressLint("SimpleDateFormat")
    @Throws(IOException::class)
    private fun createImageFile(): File {
        // Create an image file name
        val timeStamp = SimpleDateFormat("yyyyMMdd_HHmmss").format(Date())
        val imageFileName = "JPEG_" + timeStamp + "_"
        val storageDir = getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        val image = File.createTempFile(
            imageFileName,  /* prefix */
            ".jpg",  /* suffix */
            storageDir /* directory */
        )
        // Save a file: path for use with ACTION_VIEW intents
        mCurrentPhotoPath = image.absolutePath
        return image
    }





}
