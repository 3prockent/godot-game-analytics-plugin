package com.gameanalytics.godotgameanalytics;

import android.app.Activity;
import android.util.JsonReader;
import android.util.Log;

import com.gameanalytics.sdk.GAErrorSeverity;
import com.gameanalytics.sdk.GAProgressionStatus;
import com.gameanalytics.sdk.GAResourceFlowType;
import com.gameanalytics.sdk.GAAdAction;
import com.gameanalytics.sdk.GAAdType;
import com.gameanalytics.sdk.GAAdError;
import com.gameanalytics.sdk.GameAnalytics;


import org.godotengine.godot.Dictionary;
import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;
import org.godotengine.godot.plugin.UsedByGodot;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class GodotGameAnalytics extends GodotPlugin
{
    private Activity activity = null;
    private static final String VERSION = "godot 3.0.0";

    public GodotGameAnalytics(Godot godot)
    {
        super(godot);
        this.activity = godot.getActivity();
    }

    @Override
    public String getPluginName()
    {
        return "GodotGameAnalytics";
    }


    @UsedByGodot
    public void init(String gameKey, String secretKey)
    {
        GameAnalytics.configureSdkGameEngineVersion(VERSION);
        GameAnalytics.initialize(this.activity, gameKey, secretKey);
    }


    @UsedByGodot
    public void set_enabled_verbose_log(boolean flag)
    {
        GameAnalytics.setEnabledVerboseLog(flag);
    }


    @UsedByGodot
    public void set_enabled_info_log(boolean flag)
    {
        GameAnalytics.setEnabledInfoLog(flag);
    }


    @UsedByGodot
    public void set_enabled_event_submission(boolean flag)
    {
        GameAnalytics.setEnabledEventSubmission(flag);
    }

    @UsedByGodot
    public void add_impression_event(String adNetworkVersion, Dictionary data)
    {
        try {

            JSONObject impressionData = new JSONObject();
            Set<String> keys = data.keySet();

            for (String key : keys) {
                Object value = data.get(key);
                if (value instanceof Number || value instanceof Boolean) {
                    impressionData.put(key, value);
                } else {
                    impressionData.put(key, String.valueOf(value));
                }
            }

            GameAnalytics.addImpressionMaxEvent(adNetworkVersion,impressionData);

            Log.d("GameAnalytics", "Sent ad_impression: " + impressionData.toString());
        } catch (Exception e) {
            Log.e("GameAnalytics", "Failed to send ad_impression: " + e.toString());
        }
    }
}
