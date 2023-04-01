package com.example.itec_t3nsa

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.media.Image
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import com.google.firebase.ml.vision.FirebaseVision
import com.google.firebase.ml.vision.cloud.landmark.FirebaseVisionCloudLandmark
import com.google.firebase.ml.vision.common.FirebaseVisionImage
import com.google.firebase.ml.vision.common.FirebaseVisionImageMetadata
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import kotlinx.coroutines.tasks.await
import java.io.IOException


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.itec/getLandmarksChannel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if(call.method.equals("getLandmarks")) {
                try {
                    val hashMap = call.arguments as HashMap<*,*>
                    val path = hashMap["image"]
                   // result.success(path)
                    Log.d("path", path.toString())
                    GlobalScope.launch {
                        val response = getLandmarks(path as String)
                        Log.d("response", response.toString())
                        var tags : String= ""

                        for(tag in response) {
                            tags += "${tag.landmark},"
                        }
                        result.success(tags)
                    }


                } catch (e : IOException) {
                    result.error("1000","Flutter MethodChannel: ${e.message}",e.cause)
                }

            }
        }
    }


    private suspend fun getLandmarks(image2: String) : List<FirebaseVisionCloudLandmark> {
        var image: FirebaseVisionImage
        var landmarkDescription: String = ""
//        val metadata = FirebaseVisionImageMetadata.Builder()
//            .setFormat(FirebaseVisionImageMetadata.IMAGE_FORMAT_NV21)
//            .setWidth(0)
//            .setHeight(0)
//            .setRotation(FirebaseVisionImageMetadata.ROTATION_0)
//            // Set other optional properties here
//            .build()
        val bitmap = BitmapFactory.decodeFile(image2)
                image = FirebaseVisionImage.fromBitmap(bitmap)

        val task =                 FirebaseVision.getInstance()
            .visionCloudLandmarkDetector.detectInImage(image)
        return task.await()
    }
}
