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

public class ReturnClass implements Parcelable, Serializable
{
    private static final String FIELD_ID = "id";

    @Expose
    @SerializedName(FIELD_ID)
    private Long id;

    public ReturnClass() {

    }

    public ReturnClass(JSONObject jsonObject) {
        parseObject(jsonObject);
    }

    public ReturnClass(String jsonString) {
        try {
            parseString(jsonString);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    protected void parseString(String jsonString) throws JSONException {
        if (!jsonString.trim().startsWith("{"))
            jsonString = "{\"" + FIELD_ID + "\" : " + jsonString + "}";
        JSONObject jsonObject = new JSONObject(jsonString);
        parseObject(jsonObject);
    }

    protected void parseObject(JSONObject object)
    {
        this.id = object.optLong(FIELD_ID);
    }

    public void setId(Long value) {
        this.id = value;
    }

    public Long getId() {
        return this.id;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof ReturnClass) {
            return ((ReturnClass) obj).getId().equals(id) ;
        }
        return false;
    }
    @Override
    public int hashCode(){
        return (id.hashCode());
    }

    @Override
    public String toString() {
        Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
        return gson.toJson(this);
    }

    private ReturnClass(Parcel in) {
        id = in.readLong();
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeLong(id);
    }

    public static final Parcelable.Creator<ReturnClass> CREATOR = new Parcelable.Creator<ReturnClass>() {
        public ReturnClass createFromParcel(Parcel in) {
            return new ReturnClass(in);
        }

        public ReturnClass[] newArray(int size) {
            return new ReturnClass[size];
        }
    };
}
