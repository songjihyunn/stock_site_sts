package com.pkt.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/member/")
@Log4j
public class MailSend {


    @GetMapping("email")
    public Map<String, String> doMail(String email, HttpSession session) throws ServletException, IOException {
        log.info("email:" + email);

        String receiver = email;
        String subject = "이메일 인증 번호"; // 이메일 제목은 고정
        String verificationCode = generateVerificationCode(); // 랜덤으로 생성한 인증번호

        // Session 객체를 사용하여 이메일을 보내는 코드는 여기서부터
        String user = "zzxas2@gmail.com";
        String password = "ermrglsiczpgnzdu"; // 앱 비밀번호 사용

        Map<String, String> response = new HashMap<>();

        try {
            Properties p = new Properties();
            p.put("mail.smtp.starttls.enable", "true");
            p.put("mail.smtp.host", "smtp.gmail.com");
            p.put("mail.smtp.auth", "true");
            p.put("mail.smtp.port", "587");

            Session s = Session.getInstance(p, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, password);
                }
            });

            Message m = new MimeMessage(s);
            Address receiver_address = new InternetAddress(receiver);

            m.setHeader("content-type", "text/html;charset=utf-8");
            m.addRecipient(Message.RecipientType.TO, receiver_address);
            m.setSubject(subject);
            m.setContent(verificationCode, "text/html;charset=utf-8");
            m.setSentDate(new Date());

            Transport.send(m);

            // 세션에 인증번호를 저장
            session.setAttribute("verificationCode", verificationCode);

            response.put("status", "success");
            response.put("verificationCode", verificationCode);
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "fail");
            return response;
        }
    }

    // 랜덤으로 6자리 인증번호 생성하는 메서드
    private String generateVerificationCode() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10)); // 0부터 9까지의 숫자 중 랜덤으로 선택
        }
        return sb.toString();
    }
}