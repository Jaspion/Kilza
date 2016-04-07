package ;

import org.json.*;
import java.io.Serializable;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.SerializedName;
import com.google.gson.annotations.Expose;

public class Basearray implements Serializable
{
    private static final String FIELD_BASEARRAYOBJECT = "BaseArrayObject";

    @Expose
    @SerializedName(FIELD_BASEARRAYOBJECT)
    private ArrayList<String> basearrayobject;

    public Basearray() {

    }

    public Basearray(JSONObject jsonObject) {
        parseObject(jsonObject);
    }

    public Basearray(String jsonString) {
        try {
            parseString(jsonString);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    protected void parseString(String jsonString) throws JSONException {
        if (!jsonString.trim().startsWith("{"))
            jsonString = "{\"" + FIELD_BASEARRAYOBJECT + "\" : " + jsonString + "}";
        JSONObject jsonObject = new JSONObject(jsonString);
        parseObject(jsonObject);
    }

    protected void parseObject(JSONObject object)
    {
        if (object.optJSONArray(FIELD_BASEARRAYOBJECT) != null)
        {
            this.basearrayobject = new ArrayList<>();
            JSONArray basearrayobjectJsonArray = object.optJSONArray(FIELD_BASEARRAYOBJECT);
            for (int i = 0; i < basearrayobjectJsonArray.length(); i++) {
                String basearrayobject = basearrayobjectJsonArray.optJSONString(i);
                this.basearrayobject.add(new String(basearrayobject));
            }
        }
    }

    public void setBasearrayobject(ArrayList<String> value) {
        this.basearrayobject = value;
    }

    public ArrayList<String> getBasearrayobject() {
        return this.basearrayobject;
    }


    @Override
    public String toString() {
      Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
      return gson.toJson(this);
    }
}
