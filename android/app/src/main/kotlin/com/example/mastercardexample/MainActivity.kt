package com.example.mastercardexample

import android.content.Intent

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    private val channel = "masterCardChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if (call.method == "startPayment") {
                startPayment(result,call)
            }
            else {
                result.notImplemented()
            }
        }
    }

    private fun startPayment(result: MethodChannel.Result, call: MethodCall) {
//        MasterpassMerchant.initialize(masterpassMerchantConfiguration, masterpassInitCallback);
        result.success("Success")

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
    }
}
