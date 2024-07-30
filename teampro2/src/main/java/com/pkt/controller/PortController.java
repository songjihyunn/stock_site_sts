package com.pkt.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pkt.mapper.PortMapper;
import com.pkt.model.PortVO;
import com.pkt.model.StockDataVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/port/")
public class PortController {

    @Autowired
    private PortMapper mapper;
    
    // GET 요청 매핑: 포트폴리오 등록 페이지 표시
    @GetMapping("/join")
    public String joinGET(PortVO port) {
        log.info("join get ...........");
        return "port/join"; // "port/join" 뷰 반환 (WEB-INF/views/port/join.jsp)
    }
    
    // POST 요청 매핑: 포트폴리오 추가
    @PostMapping("/join")
    public String joinPOST(PortVO port, RedirectAttributes rttr) {
        log.info("join post ...........");
        log.info(port.toString());

        try {
            mapper.create(port);
            log.info("성공적으로 포트폴리오를 추가했습니다.");
            rttr.addFlashAttribute("message", "성공적으로 포트폴리오를 추가했습니다.");
        } catch (Exception e) {
            log.error("포트폴리오 추가 실패. 에러코드: ", e);
            rttr.addFlashAttribute("message", "포트폴리오를 추가하지 못했습니다.");
        }

        return "redirect:/port/list"; // 포트폴리오 목록 페이지로 리디렉트
    }

    // POST 요청 매핑: 포트폴리오 수정
    @PostMapping("/modify")
    public String modifyPOST(PortVO port, RedirectAttributes rttr) {
        log.info("modify post ...........");
        log.info(port.toString());

        try {
            mapper.update(port);
            log.info("성공적으로 포트폴리오를 수정했습니다.");
            rttr.addFlashAttribute("message", "성공적으로 포트폴리오를 수정했습니다.");
        } catch (Exception e) {
            log.error("포트폴리오 수정 실패. 에러코드: ", e);
            rttr.addFlashAttribute("message", "포트폴리오를 수정하지 못했습니다.");
        }

        return "redirect:/port/list"; // 포트폴리오 목록 페이지로 리디렉트
    }

    // 포트폴리오 삭제 처리
    @PostMapping("/delete")
    public String deletePOST(String userid, String company, String stock_id, RedirectAttributes rttr) {
        log.info("delete post ...........");
        

        try {
            mapper.delete(userid, company, stock_id);
            log.info("성공적으로 포트폴리오를 삭제했습니다.");
            rttr.addFlashAttribute("message", "성공적으로 포트폴리오를 삭제했습니다.");
        } catch (Exception e) {
            log.error("포트폴리오 삭제 실패. 에러코드: ", e);
            rttr.addFlashAttribute("message", "포트폴리오를 삭제하지 못했습니다.");
        }

        return "redirect:/port/list"; // 포트폴리오 목록 페이지로 리디렉트
    }

    @GetMapping("/list")
    public String listByUser(HttpSession session, Model model) {
    	 // 세션에서 사용자 ID 가져오기
        String userid = (String) session.getAttribute("id");
        
        if (userid == null || userid.isEmpty()) {
            log.warn("세션에 사용자 ID가 없습니다.");
            return "redirect:/member/login"; // 사용자 ID가 없으면 로그인 페이지로 리다이렉트
        }
        
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://192.168.0.15:5000/get_port_price";
        
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        
        String requestBody = "{\"userid\":\"" + userid + "\"}";
        HttpEntity<String> request = new HttpEntity<>(requestBody, headers);
        
        ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);
        
        String stockData = response.getBody();
        
        // JSON 문자열을 JSONArray로 파싱
        JSONArray jsonArray = new JSONArray(stockData);

        // StockDataVO 객체를 담을 리스트 생성
        List<StockDataVO> sd = new ArrayList<>();

        // JSONArray의 각 요소를 순회하며 StockDataVO 객체 생성 및 리스트에 추가
        for (int i = 0; i < jsonArray.length(); i++) {
            // 각 요소를 JSONObject로 가져오기
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            
            // JSONObject에서 stock_code 필드 값을 가져오기
            String stockCode = jsonObject.getString("stock_code");
            double price = jsonObject.optDouble("price", Double.NaN);
            int stock_id = jsonObject.getInt("stock_id");
            
            // StockDataVO 객체 생성하여 리스트에 추가
            sd.add(new StockDataVO(stockCode, price, stock_id));
        }
        
        model.addAttribute("sd", sd);
        System.out.println(sd);
        
        
        log.info("사용자 {}의 포트폴리오 목록을 가져옵니다.");
        List<PortVO> portList = mapper.getListByUserId(userid);

        // 중복된 company 항목을 제거하기 위해 Set을 사용
        Set<PortVO> uniquePortSet = new HashSet<>(portList);

        // Set을 다시 List로 변환하고 역순으로 정렬
        List<PortVO> uniquePortList = new ArrayList<>(uniquePortSet);
        Collections.reverse(uniquePortList); // 역순 정렬
        System.out.println("list"+uniquePortList);
        model.addAttribute("list", uniquePortList); // 모델에 중복 제거된 역순 정렬된 목록 추가
        return "port/list"; // 목록을 표시할 뷰 이름 반환
    }
}
