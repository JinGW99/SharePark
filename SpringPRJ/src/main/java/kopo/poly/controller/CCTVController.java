package kopo.poly.controller;


import kopo.poly.dto.CCTVDTO;

import kopo.poly.service.ICCTVService;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.List;


@Slf4j
@Controller
public class CCTVController {

    // Map 객체를 사용한 데이터 처리
    @Resource(name = "CCTVService")
    private ICCTVService cctvservice;


    @RequestMapping(value = "PRJ/CCTV")
    public final int insertCCTV(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                                ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".insertDATA start");

        int res = cctvservice.insertCCTV();

        log.info(this.getClass().getName() + ".insertDATA ENd!");

        return res;
    }

    @GetMapping(value = "cctvMap/test")
    public String getCCTV(ModelMap model, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{

        log.info(this.getClass().getName() + ".getCCTV start");

        List<CCTVDTO> rList = cctvservice.getCCTV();

        model.addAttribute("rList", rList);

        log.info(this.getClass().getName() + "getCCTV end!");

        log.info("rList" + rList);

        return "PRJ/cctv";
    }



}


