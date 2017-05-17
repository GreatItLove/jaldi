package com.jaldi.services.common.date;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.jaldi.services.common.Constants;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/16/17
 * Time: 11:06 PM
 */
public class CommonDateTimeSerializer   extends JsonSerializer<Date> {

    @Override
    public void serialize(Date date, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)  throws IOException {
        SimpleDateFormat format = new SimpleDateFormat(Constants.COMMON_DATE_TIME_FORMAT);
        jsonGenerator.writeString(format.format(date));
    }
}