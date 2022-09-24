package kopo.poly.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface IS3Service {

    //파일 업로드
    String upload(MultipartFile mf, String user_id, String ext) throws IOException;

    // 파일 삭제
    int fileDelete(String fileName)throws IOException;



}
