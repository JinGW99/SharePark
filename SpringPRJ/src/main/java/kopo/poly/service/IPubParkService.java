package kopo.poly.service;

import kopo.poly.dto.PubParkDTO;

import java.util.List;

public interface IPubParkService {

    int insertPubPark() throws Exception;

    List<PubParkDTO> getPubPark() throws Exception;
}
