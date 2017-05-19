package com.jaldi.services.common;

import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.MessageAttributeValue;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by: Sedrak Dalaloyan
 * Date: 5/18/17
 * Time: 6:32 PM
 */
@Service
public class MessageService {

    @Value("${aws.sns.sms.accessKey}")
    private String accessKey;

    @Value("${aws.sns.sms.secretKey}")
    private String secretKey;

    private AmazonSNSClient snsClient;

    @PostConstruct
    public void init() {
        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
        snsClient = new AmazonSNSClient(credentials);
    }

    public String sendVerificationSms(String phoneNumber, String code) {
        Map<String, MessageAttributeValue> smsAttributes =
                new HashMap<>();
        smsAttributes.put("AWS.SNS.SMS.SenderID", new MessageAttributeValue()
                .withStringValue("Jaldi")
                .withDataType("String"));
        smsAttributes.put("AWS.SNS.SMS.SMSType", new MessageAttributeValue()
                .withStringValue("Transactional")
                .withDataType("String"));
        String message = "Your Jaldi verification code is " + code;
        return sendSmsMessage(snsClient, message, phoneNumber, smsAttributes);
    }

    public String sendSmsMessage(AmazonSNSClient snsClient, String message,
                                      String phoneNumber, Map<String, MessageAttributeValue> smsAttributes) {
        PublishResult result = snsClient.publish(new PublishRequest()
                .withMessage(message)
                .withPhoneNumber(phoneNumber)
                .withMessageAttributes(smsAttributes));
        return result.getMessageId();
    }
}
