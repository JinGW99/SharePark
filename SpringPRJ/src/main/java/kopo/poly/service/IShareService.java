package kopo.poly.service;

import kopo.poly.dto.ImgDTO;
import kopo.poly.dto.ShareDTO;
import kopo.poly.dto.UserInfoDTO;

import java.util.List;

public interface IShareService {


    //주차장 등록하기
    int InsertShare(ShareDTO pDTO) throws Exception;

    //내꺼 주차장 리스트
    List<ShareDTO> getShareList(String user_id) throws Exception;

    //리스트
    List<ShareDTO> getShareListAll() throws Exception;

    //주차장 상세보기
    ShareDTO getParkInfo(ShareDTO pDTO) throws Exception;

    //주차장 수정
    void updateParkInfo(ShareDTO pDTO) throws Exception;

    //주차장 삭제
    void deleteParkInfo(ShareDTO pDTO) throws Exception;

    //주차예약
    int Reservation(ShareDTO pDTO) throws Exception;

    List<ShareDTO> reserPark(String user_id) throws Exception;

    //예약 취소
    void deleteReser(ShareDTO pDTO) throws Exception;

    int InsertTitle(ImgDTO iDTO) throws Exception;

}
