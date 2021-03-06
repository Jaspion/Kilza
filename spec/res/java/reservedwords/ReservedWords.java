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

public class ReservedWords implements Parcelable, Serializable
{
    private static final String FIELD__IF = "if";
    private static final String FIELD__RETURN = "return";

    @Expose
    @SerializedName(FIELD__IF)
    private String _if;

    @Expose
    @SerializedName(FIELD__RETURN)
    private ReturnClass _return;

    public ReservedWords() {

    }

    public ReservedWords(JSONObject jsonObject) {
        parseObject(jsonObject);
    }

    public ReservedWords(String jsonString) {
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
        this._if = object.optString(FIELD__IF);
        this._return = new ReturnClass(object.optJSONObject(FIELD__RETURN));
    }

    public void setIf(String value) {
        this._if = value;
    }

    public String getIf() {
        return this._if;
    }

    public void setReturn(ReturnClass value) {
        this._return = value;
    }

    public ReturnClass getReturn() {
        return this._return;
    }


    @Override
    public String toString() {
        Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
        return gson.toJson(this);
    }

    private ReservedWords(Parcel in) {
        _if = in.readString();
        _return = (ReturnClass) in.readParcelable(ReturnClass.class.getClassLoader());
    }

    public int describeContents() {
        return 0;
    }

    public void writeToParcel(Parcel out, int flags) {
        out.writeString(_if);
        out.writeParcelable(_return, flags);
    }

    public static final Parcelable.Creator<ReservedWords> CREATOR = new Parcelable.Creator<ReservedWords>() {
        public ReservedWords createFromParcel(Parcel in) {
            return new ReservedWords(in);
        }

        public ReservedWords[] newArray(int size) {
            return new ReservedWords[size];
        }
    };
}
