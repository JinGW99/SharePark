package kopo.poly.persistance;

import kopo.poly.dto.ImgDTO;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface IImgMapper {

	//파일 경로 저장하기
	 int insertFilePath(ImgDTO fDTO) throws Exception;

    // path 가져오기
    ImgDTO getFilePath(ImgDTO fDTO);

}
