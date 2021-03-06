/**
* Created on <%= Time.now.strftime("%Y-%m-%d") %>
* Generated by Kilza https://github.com/Jaspion/Kilza
*/
package ;

import android.os.Parcelable;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.SerializedName;
import com.google.gson.annotations.Expose;

import java.io.Serializable;

import org.json.*;

public class Arrnull implements Parcelable, Serializable
{

    public Arrnull() {

    }

    public Arrnull(JSONObject jsonObject) {
        parseObject(jsonObject);
    }

    public Arrnull(String jsonString) {
        try {
            parseString(jsonString);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    protected void parseString(String jsonString) throws JSONException {
        JSONObject jsonObject = new JSONObject(jsonString);
        parseObject(jsonObject);
    }

    protected void parseObject(JSONObject object)
    {
    }


    @Override
    public String toString() {
        Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
        return gson.toJson(this);
    }

    private Arrnull(Parcel in) {
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
    }

    public static final Parcelable.Creator<Arrnull> CREATOR = new Parcelable.Creator<Arrnull>() {
        public Arrnull createFromParcel(Parcel in) {
            return new Arrnull(in);
        }

        public Arrnull[] newArray(int size) {
            return new Arrnull[size];
        }
    };
}
