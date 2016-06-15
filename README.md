# Jaspion Kilza

[![Gem Version](https://badge.fury.io/rb/jaspion-kilza.svg)](https://badge.fury.io/rb/kilza)

[![Build Status](https://travis-ci.org/Jaspion/Kilza.svg?branch=master)](https://travis-ci.org/Jaspion/Kilza)

[![Coverage Status](https://coveralls.io/repos/github/Jaspion/Kilza/badge.svg?branch=master)](https://coveralls.io/github/Jaspion/Kilza?branch=master)

[![Inline docs](http://inch-ci.org/github/jaspion/kilza.svg?branch=master)](http://inch-ci.org/github/jaspion/kilza)

Ruby gem that can convert JSON strings in Objects.

It supports Objective-C and Java classes. Contribuition would be appreciate.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jaspion-kilza'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jaspion-kilza

## Binary

Just call:

	kilza

And the Kilza will guide you.

## Usage in code

Just

	require 'jaspion/kilza'

And then

```
json_string = "..."

java = Jaspion::Kilza::Java.new(json_string)
java.classes("MyBaseClass").each { |c|
	c.sources.each{ |s|
	File.write(File.join("my/target/path", s.file_name), s.source)
	}
}
```

## Example

Let's see in action.
Suppose our variable **json_string** have the following string:

```
{

    "Code": ​110,
    "Message": ""

}
```

Calling the code above:

```
java = Jaspion::Kilza::Java.new(json_string)
java.classes("MyBaseClass").each { |c|
	c.sources.each{ |s|
	File.write(File.join("my/target/path", s.file_name), s.source)
	}
}
```

Will generate:

```
package ;

import org.json.*;
import java.io.Serializable;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.SerializedName;
import com.google.gson.annotations.Expose;

public class Mybaseclass implements Serializable
{
    private static final String FIELD_CODE = "Code";
    private static final String FIELD_MESSAGE = "Message";

    @Expose
    @SerializedName(FIELD_CODE)
    private Long code;
    @Expose
    @SerializedName(FIELD_MESSAGE)
    private String message;

    public Mybaseclass() {

    }

    public Mybaseclass(JSONObject jsonObject) {
        parseObject(jsonObject);
    }

    public Mybaseclass(String jsonString) {
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
        this.code = object.optLong(FIELD_CODE);
        this.message = object.optString(FIELD_MESSAGE);
    }

    public void setCode(Long value) {
        this.code = value;
    }

    public Long getCode() {
        return this.code;
    }

    public void setMessage(String value) {
        this.message = value;
    }

    public String getMessage() {
        return this.message;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Mybaseclass) {
            return ((Mybaseclass) obj).getCode().equals(code) &&
            ((Mybaseclass) obj).getMessage().equals(message) ;
        }
        return false;
    }
    @Override
    public int hashCode(){
        return (code.hashCode() +
        message.hashCode());
    }

    @Override
    public String toString() {
      Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
      return gson.toJson(this);
    }
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jaspion/kilza. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
