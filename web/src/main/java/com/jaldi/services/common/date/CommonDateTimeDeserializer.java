package com.jaldi.services.common.date;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.jaldi.services.common.Constants;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/16/17
 * Time: 3:56 PM
 */
public class CommonDateTimeDeserializer extends JsonDeserializer<Date> {

    @Override
    public Date deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException {

        SimpleDateFormat format = new SimpleDateFormat(Constants.COMMON_DATE_TIME_FORMAT);
        String date = jsonParser.getText();
        try {
            Date dateObj = format.parse(date);
            return dateObj;
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }
}