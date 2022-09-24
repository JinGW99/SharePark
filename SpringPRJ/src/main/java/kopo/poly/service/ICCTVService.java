package kopo.poly.service;

import kopo.poly.dto.CCTVDTO;

import java.util.List;

public interface ICCTVService {

    int insertCCTV()throws Exception;

    List<CCTVDTO> getCCTV() throws Exception;
}
