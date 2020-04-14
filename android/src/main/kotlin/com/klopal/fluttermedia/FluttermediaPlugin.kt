package com.klopal.fluttermedia

import android.Manifest
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.gson.Gson
import io.flutter.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar


/** FlutterMediaPlugin */
public class FlutterMediaPlugin(private val registrar: Registrar) : MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {

    private var permissionsRequestCode = 123;

    private val permission = Manifest.permission.READ_EXTERNAL_STORAGE

    private var gson: Gson? = Gson()

    private val flutterMediaProvider = FlutterMediaProvider(registrar.activity())

    private lateinit var result: Result
    private lateinit var call: MethodCall


    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "fluttermedia")
            channel.setMethodCallHandler(FlutterMediaPlugin(registrar))
        }
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getImages") {
            this.result = result
            this.call = call

            registrar.addRequestPermissionsResultListener(this)

            this.checkPermission()

        } else {
            result.notImplemented()
        }
    }


    private fun checkPermission() {

        if (ContextCompat.checkSelfPermission(registrar.activity(), permission) != PackageManager.PERMISSION_GRANTED) {
            // Permission is not granted
            // Should we show an explanation?
            if (ActivityCompat.shouldShowRequestPermissionRationale(registrar.activity(), permission)) {
                // Show an explanation to the user *asynchronously* -- don't block
                // this thread waiting for the user's response! After the user
                // sees the explanation, try again to request the permission.
                Log.e(TAG, "Explanation needed")
                result.error("PERMISSION_DENIED", "", null)

            } else {
                // No explanation needed, we can request the permission.
                ActivityCompat.requestPermissions(registrar.activity(), arrayOf(permission), permissionsRequestCode)
                // permissionsRequestCode is an app-defined int constant.
                // The callback method gets the result of the request.
            }
        } else {
            sendImages()
        }


    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray): Boolean {
        Log.i(TAG, "onRequestPermissionsResult $requestCode")

        when (requestCode) {
            permissionsRequestCode -> {
                // If request is cancelled, the result arrays are empty.
                if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    // permission was granted, yay!
                    sendImages();
                } else {
                    // permission denied, boo!
                    Log.e(TAG, "Permission was denied")
                    result.error("PERMISSION_DENIED", "", null)
                }
            }
        }

        return true
    }


    private fun sendImages() {
        val limit = call.argument<Int>("limit")
        val images = flutterMediaProvider.queryImages(limit)
        result.success(gson?.toJson(images))
    }

}


private const val TAG = "FlutterMediaPlugin"
