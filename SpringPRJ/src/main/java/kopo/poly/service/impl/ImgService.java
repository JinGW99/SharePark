package kopo.poly.service.impl;

import kopo.poly.dto.ImgDTO;

import kopo.poly.persistance.ICCTVMapper;
import kopo.poly.persistance.IImgMapper;
import kopo.poly.persistance.mapper.IShareMapper;
import kopo.poly.service.IImgService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Slf4j
@Service("ImgService")
public class ImgService implements IImgService {


    //mapper 연동
    private final IImgMapper imgMapper;

    @Autowired
    public ImgService(IImgMapper imgMapper){
        this.imgMapper = (IImgMapper) imgMapper;
    }

    //파일 저장 경로
    @Override
    public int insertFilePath(ImgDTO fDTO) throws Exception {

        log.info(this.getClass().getName()+". insetfilePath Start!");

        int res =imgMapper.insertFilePath(fDTO);

        log.info(this.getClass().getName()+". insetfilePath end!");

        return res;
    }

    //파일 저장 경로 가져오기!
    @Override
    public ImgDTO getPath(ImgDTO fDTO) throws Exception{
        log.info(this.getClass().getName()+"getFilePath Start!");

        fDTO = imgMapper.getFilePath(fDTO);

        log.info(this.getClass().getName()+"getFilePath end!");
        return fDTO;
    }

}
