package kopo.poly.dto;

import lombok.Data;

@Data
public class ImgDTO {

    private String file_seq; // 파일 시퀸스
    private String save_file_path; // 저장된 이미지 파일의 파일 저장경로
    private String save_file_name; // 저장된 파일 이미지 파일 이름
    private String org_file_name; // 원래 파일명
    private String ext; // 파일 확장자
    private String reg_dt; // 최근 등록일
    private String user_id;//등록자 아이디
    private String sp_title;

}