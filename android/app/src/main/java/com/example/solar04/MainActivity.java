package com.example.solar04;

import android.hardware.Camera;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.os.Build;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "get";

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            float k=5;
                            float horizontalcameraangle=-1;
                            float verticalcameraangle=-1;
                            Camera camera = Camera.open(0);
                            if(call.method.equals("get")){
                                Camera.Parameters p = camera.getParameters();
                                k=p.getFocalLength();
                                result.success(k);
                            }
                            if(call.method.equals("horizon")){
                                try {
                                    Camera.Parameters p = camera.getParameters();
                                    horizontalcameraangle = p.getHorizontalViewAngle();
                                }catch (Exception e){
                                    Log.v("Error","cant get angle");
                                }
                                result.success(horizontalcameraangle);

                            }
                            if(call.method.equals("vert")){
                                try {
                                    Camera.Parameters p = camera.getParameters();
                                    verticalcameraangle = p.getVerticalViewAngle();
                                }catch (Exception e){
                                    Log.v("Error","cant get angle");
                                }
                                result.success(verticalcameraangle);

                            }

                        }
                );
    }



}
