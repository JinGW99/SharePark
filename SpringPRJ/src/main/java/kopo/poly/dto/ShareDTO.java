package kopo.poly.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShareDTO {

    private String sp_seq;
    private String sp_title;
    private String sp_contents;
    private String user_id;
    private String reg_id;
    private String reg_dt;
    private String start_time;
    private String end_time;
    private String sp_place;
    private String chg_id;
    private String chg_dt;
    private String reser_id;
    private String save_file_path; // 저장된 이미지 파일의 파일 저장경로
}
