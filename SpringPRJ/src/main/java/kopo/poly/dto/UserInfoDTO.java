package kopo.poly.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserInfoDTO {

    private String user_seq;
    private String user_id;
    private String password;
    private String email;
    private String address;
    private String reg_id;
    private String reg_dt;
    private String chg_id;
    private String chg_dt;
    private String user_phone;

    public String exists_yn;



}
