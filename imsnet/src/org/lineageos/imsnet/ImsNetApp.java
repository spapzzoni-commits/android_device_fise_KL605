package org.lineageos.imsnet;

import android.app.Application;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class ImsNetApp extends Application {
    private static final String TAG = "ImsNet";

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "ImsNetApp onCreate");
        startService(new Intent(this, ImsNetService.class));
    }

    public static class BootReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            Log.i(TAG, "BootReceiver: " + intent.getAction());
            context.startService(new Intent(context, ImsNetService.class));
        }
    }
}

