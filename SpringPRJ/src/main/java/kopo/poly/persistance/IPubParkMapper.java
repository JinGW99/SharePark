package kopo.poly.persistance;

import kopo.poly.dto.PubParkDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface IPubParkMapper {

    int insertPubPark(List<PubParkDTO> rList, String colNm) throws Exception;

    List<PubParkDTO> getPubPark(String colNm) throws Exception;
}
