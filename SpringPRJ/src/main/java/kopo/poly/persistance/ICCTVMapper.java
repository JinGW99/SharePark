package kopo.poly.persistance;

import kopo.poly.dto.CCTVDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface ICCTVMapper {

    int insertCCTV(List<CCTVDTO> rList, String colNm) throws Exception;

    List<CCTVDTO> getCCTV(String colNm) throws Exception;
}
