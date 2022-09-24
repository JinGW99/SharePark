package kopo.poly.service.impl;

import kopo.poly.dto.PubParkDTO;
import kopo.poly.persistance.IPubParkMapper;
import kopo.poly.service.IPubParkService;
import kopo.poly.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
@Slf4j
@Service("PubParkService")
public class PubParkService  implements IPubParkService {


    @Resource(name = "PubParkMapper")
    private IPubParkMapper pubParkMapper;

    @Override
    public int insertPubPark() throws Exception {

        int res = 0;

        List<PubParkDTO> pList = new LinkedList<>();

        log.info(this.getClass().getName() + "start@@");

        StringBuilder urlBuilder = new StringBuilder("http://211.252.37.224/rest/parking"); /*URL*/

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        log.info("#####파싱한데이터########");
        log.info(sb.toString());


        JSONObject result = null;
        result = (JSONObject) new JSONParser().parse(sb.toString());
        //result.get("response");
        JSONArray result2 = (JSONArray) result.get("parkingInfoList");

        log.info(String.valueOf(result2));


        for (int i = 0; i < result2.size(); i++) {

            JSONObject pubpark = (JSONObject) result2.get(i);
            String parkingName = String.valueOf(pubpark.get("parkingName"));  //주차장이름
            String operationRuleNm = String.valueOf(pubpark.get("operationRuleNm")); //공영인지 민영인지확인
            String addrRoad = (String) pubpark.get("addrRoad"); //도로명 주소
            String payYn = (String) pubpark.get("payYn"); //유무료 금액확인
            String lat = (String) pubpark.get("lat"); // X좌표
            String lng = (String) pubpark.get("lng"); // Y 좌표

            log.info("parkingName :" + parkingName);
            log.info("operationRuleNm : " + operationRuleNm);
            log.info("addrRoad : " + addrRoad);
            log.info("payYn : " + payYn);
            log.info("lat : " + lat);
            log.info("lng : " + lng);

            PubParkDTO pDTO = new PubParkDTO();

            pDTO.setParkingName(parkingName);
            pDTO.setOperationRuleNm(operationRuleNm);
            pDTO.setAddrRoad(addrRoad);
            pDTO.setPayYn(payYn);
            pDTO.setLat(lat);
            pDTO.setLng(lng);

            pList.add(pDTO);

        }
        String colNm = "PubPark_" + DateUtil.getDateTime("yyyy_MM_dd_hh_mm");

        res = pubParkMapper.insertPubPark(pList, colNm);

        return res;
    }

    @Override
    public List<PubParkDTO> getPubPark() throws Exception {
        log.info(this.getClass().getName() + ".getPubPark sstart");


        String colNm = "PubPark_" + DateUtil.getDateTime("yyyy_MM_dd_hh_mm");

        List<PubParkDTO> rList = null;

        if (this.insertPubPark()==1){

            rList = pubParkMapper.getPubPark(colNm);

            if (rList==null){
                rList = new LinkedList<>();
            }
        }else {
            rList = new LinkedList<>();
        }

        log.info(this.getClass().getName() + ".getPub End!");

        return rList;
    }
}



