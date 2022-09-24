package kopo.poly.service;

import kopo.poly.dto.ImgDTO;



public interface IImgService {

    //이미지 경로저장
    int insertFilePath(ImgDTO fDTO)throws Exception;

    //이미지 경로 가져오기
    ImgDTO getPath(ImgDTO fDTO)throws Exception;

}
