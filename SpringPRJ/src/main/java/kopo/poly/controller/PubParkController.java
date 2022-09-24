package kopo.poly.controller;


import kopo.poly.dto.PubParkDTO;

import kopo.poly.service.IPubParkService;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import java.util.ArrayList;
import java.util.List;


@Slf4j
@
        Controller
public class PubParkController {

    // Map 객체를 사용한 데이터 처리
    @Resource(name = "PubParkService")
    private IPubParkService pubParkService;



    @GetMapping(value = "PRJ/PubPark")
    public int showPubPark(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                           ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".insertPubPark DATA start");

        int res = pubParkService.insertPubPark();

        log.info(this.getClass().getName() + ".insertPubPark DATA End");

        return res;

    }


    @GetMapping(value = "PRJ/pubParkMap")
    public String getPubPark(ModelMap model, HttpSession session, HttpServletRequest request, HttpServletResponse response)
        throws Exception{

        log.info(this.getClass().getName() + ".getPubPark start");

        List<PubParkDTO> rList = pubParkService.getPubPark();

        model.addAttribute("rList", rList);

        log.info(this.getClass().getName() + ".getPub End1");

        log.info("rList : " + rList);

        return "PRJ/PubParkMap";
    }
}


