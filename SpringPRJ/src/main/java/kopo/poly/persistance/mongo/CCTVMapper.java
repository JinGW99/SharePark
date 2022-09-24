package kopo.poly.persistance.mongo;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import kopo.poly.dto.CCTVDTO;
import kopo.poly.persistance.ICCTVMapper;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.springframework.stereotype.Component;


import javax.print.Doc;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Slf4j
@Component("CCTVMapper")
public class CCTVMapper extends AbstractMongoDBComon implements ICCTVMapper {


    @Override
    public final int insertCCTV(List<CCTVDTO> pList, String colNm) throws Exception {

        log.info(this.getClass().getName() + ".insertData Start!");

        int res = 0;

        if (pList == null){
            pList = new LinkedList<>();
        }

        // 데이터를 저장할 컬렉션 생성
        super.createCollection(colNm);

        // 저장할 컬렉션 객체 생성
        MongoCollection<Document> col = mongodb.getCollection(colNm);


        for (CCTVDTO pDTO : pList) {

            // DTO를 Map 데이터타입으로 변경 한 뒤, 변경된 Map 데이터타입을 Document로 변경하기
            col.insertOne(new Document(new ObjectMapper().convertValue(pDTO, Map.class)));

        }
        res = 1;

        log.info(this.getClass().getName() + ".insertData End!");

        return res;
    }

    @Override
    public final List<CCTVDTO> getCCTV(String pColNm) throws Exception {

        log.info(this.getClass().getName() + ".getCCTV start!");

        List<CCTVDTO> rList = new LinkedList<>();

        MongoCollection<Document> col = mongodb.getCollection(pColNm);

        Document projection = new Document();
        projection.append("no", "$no");
        projection.append("data", "$data");
        projection.append("lot", "$lot");
        projection.append("lat", "$lat");
        projection.append("addr", "$addr");


        FindIterable<Document> rs = col.find(new Document()).projection(projection);

        for (Document doc : rs){
            if (doc == null){
                doc = new Document();

            }
            String lot = CmmUtil.nvl(doc.getString("lot"));
            String lat = CmmUtil.nvl(doc.getString("lat"));
            String addr = CmmUtil.nvl(doc.getString("addr"));
            String data = CmmUtil.nvl(doc.getString("data"));
            String no =CmmUtil.nvl(doc.getString("no"));

            log.info("lot:" + lot);
            log.info("lat:" + lat);
            log.info("addr:" + addr);
            log.info("data:" + data);
            log.info("no:" + no);

            CCTVDTO rDTO = new CCTVDTO();

            rDTO.setNo(no);
            rDTO.setLat(lat);
            rDTO.setLot(lot);
            rDTO.setAddr(addr);
            rDTO.setData(data);

            rList.add(rDTO);
        }

        log.info(this.getClass().getName() + ".getCCTV end");

        return rList;
    }

}

