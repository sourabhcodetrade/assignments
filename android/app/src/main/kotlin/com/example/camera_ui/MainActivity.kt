package com.example.camera_ui


import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Bitmap.Config
import android.provider.MediaStore
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream


class MainActivity : FlutterActivity() {
    private val channel = "channel"
    private val cameraRequest = 1234
    private var myResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if (call.method == "cameraOn") {
                myResult = result;
               openCamera()

            }
            else {
                result.notImplemented()
            }
        }
    }

    private  fun openCamera(){
        val cameraIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        startActivityForResult(cameraIntent,cameraRequest)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == cameraRequest && resultCode == RESULT_OK) {
            val imageBitmap :Bitmap  = data?.extras?.get("data") as Bitmap
            val stream = ByteArrayOutputStream()
            imageBitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream)
            val byteArray = stream.toByteArray()
            imageBitmap.recycle()


            myResult?.success(byteArray);

        }
    }
}
