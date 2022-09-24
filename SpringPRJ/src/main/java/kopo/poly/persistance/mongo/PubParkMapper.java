package kopo.poly.persistance.mongo;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import kopo.poly.dto.PubParkDTO;
import kopo.poly.persistance.IPubParkMapper;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Slf4j
@Component("PubParkMapper")
public class PubParkMapper extends AbstractMongoDBComon implements IPubParkMapper {


    @Override
    public int insertPubPark(List<PubParkDTO> pList, String colNm) throws Exception {

        log.info(this.getClass().getName() + ".insertPubParkData Start!");

        int res = 0;

        if (pList == null) {
            pList = new LinkedList<>();
        }

        MongoCollection<Document> col = mongodb.getCollection(colNm);

        for (PubParkDTO pDTO : pList) {

            col.insertOne(new Document(new ObjectMapper().convertValue(pDTO, Map.class)));
        }
            res = 1;

            log.info(this.getClass().getName() + ".insertPubPark DATA End");

            return res;

    }

    @Override
    public List<PubParkDTO> getPubPark(String pColNm) throws Exception {
        log.info(this.getClass().getName() + ".getPUbPark Start");

        List<PubParkDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(pColNm);

        Document projection = new Document();
        projection.append("parkingName", "$parkingName");
        projection.append("operationRuleNm", "$operationRuleNm");
        projection.append("addrRoad", "$addrRoad");
        projection.append("payYn", "$payYn");
        projection.append("lat", "$lat");
        projection.append("lng", "$lng");

        FindIterable<Document> rs = col.find(new Document()).projection(projection);

        for (Document doc : rs){
            if (doc == null){
                doc = new Document();
            }

            String parkingName = CmmUtil.nvl(doc.getString("parkingName"));
            String operationRuleNm = CmmUtil.nvl(doc.getString("doperationRuleNm"));
            String addrRoad = CmmUtil.nvl(doc.getString("addrRoad"));
            String payYn = CmmUtil.nvl(doc.getString("payYn"));
            String lat = CmmUtil.nvl(doc.getString("lat"));
            String lng = CmmUtil.nvl(doc.getString("lng"));

            log.info("parkingName : " + parkingName);
            log.info("operationRuleNm : " + operationRuleNm);
            log.info("addrRoad : " + addrRoad);
            log.info("payYn : " + payYn);
            log.info("lat : " + lat);
            log.info("lng : " + lng);

            PubParkDTO rDTO = new PubParkDTO();

            rDTO.setParkingName(parkingName);
            rDTO.setOperationRuleNm(operationRuleNm);
            rDTO.setAddrRoad(addrRoad);
            rDTO.setPayYn(payYn);
            rDTO.setLat(lat);
            rDTO.setLng(lng);

            rList.add(rDTO);
        }

        log.info(this.getClass().getName() + "getPub end");

        return rList;
    }
}
