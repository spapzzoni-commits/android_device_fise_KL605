package org.lineageos.imsnet;

import android.app.Service;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkRequest;
import android.os.IBinder;
import android.telephony.SubscriptionManager;
import android.net.TelephonyNetworkSpecifier;
import android.util.Log;

public class ImsNetService extends Service {
    private static final String TAG = "ImsNet";

    private ConnectivityManager mConnectivityManager;
    private SubscriptionManager mSubscriptionManager;
    private NetworkRequest mRequest;
    private ConnectivityManager.NetworkCallback mCallback;
    private int mSubId = SubscriptionManager.INVALID_SUBSCRIPTION_ID;

    private final SubscriptionManager.OnSubscriptionsChangedListener mSubListener =
            new SubscriptionManager.OnSubscriptionsChangedListener() {
                @Override
                public void onSubscriptionsChanged() {
                    requestImsNetwork();
                }
            };

    @Override
    public void onCreate() {
        super.onCreate();
        mConnectivityManager = getSystemService(ConnectivityManager.class);
        mSubscriptionManager = getSystemService(SubscriptionManager.class);

        if (mSubscriptionManager != null) {
            mSubscriptionManager.addOnSubscriptionsChangedListener(
                    getMainExecutor(), mSubListener);
        }
        requestImsNetwork();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        requestImsNetwork();
        return START_STICKY;
    }

    private void requestImsNetwork() {
        int subId = SubscriptionManager.getDefaultDataSubscriptionId();
        if (!SubscriptionManager.isValidSubscriptionId(subId)) {
            Log.i(TAG, "requestImsNetwork: invalid subId, waiting");
            return;
        }
        if (subId == mSubId && mRequest != null) {
            return;
        }
        release();
        if (mConnectivityManager == null) {
            Log.e(TAG, "no ConnectivityManager");
            return;
        }

	NetworkRequest request = new NetworkRequest.Builder()
	        .addTransportType(NetworkCapabilities.TRANSPORT_CELLULAR)
	        .addCapability(NetworkCapabilities.NET_CAPABILITY_IMS)
	        .addCapability(NetworkCapabilities.NET_CAPABILITY_TRUSTED)
	        .setNetworkSpecifier(new TelephonyNetworkSpecifier.Builder()
	                .setSubscriptionId(subId)
	                .build())
	        .build();

        ConnectivityManager.NetworkCallback callback =
                new ConnectivityManager.NetworkCallback() {
                    @Override
                    public void onAvailable(Network network) {
                        Log.i(TAG, "IMS network available: " + network);
                    }

                    @Override
                    public void onLost(Network network) {
                        Log.i(TAG, "IMS network lost: " + network);
                    }
                };

        mRequest = request;
        mCallback = callback;
        mSubId = subId;

	try {
	    mConnectivityManager.requestNetwork(request, callback);
	    Log.i(TAG, "requestImsNetwork: requested IMS APN, subId=" + subId);
	} catch (Exception e) {
	    Log.e(TAG, "requestImsNetwork failed", e);
	}

        Log.i(TAG, "requestImsNetwork: requested IMS APN, subId=" + subId);
    }

    private void release() {
        if (mConnectivityManager != null && mCallback != null) {
            try {
                mConnectivityManager.unregisterNetworkCallback(mCallback);
            } catch (IllegalArgumentException ignored) {
            }
        }
        mCallback = null;
        mRequest = null;
        mSubId = SubscriptionManager.INVALID_SUBSCRIPTION_ID;
    }

    @Override
    public void onDestroy() {
        release();
        if (mSubscriptionManager != null) {
            mSubscriptionManager.removeOnSubscriptionsChangedListener(mSubListener);
        }
        super.onDestroy();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}

