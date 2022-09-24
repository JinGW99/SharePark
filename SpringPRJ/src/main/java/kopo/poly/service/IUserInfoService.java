package kopo.poly.service;

import kopo.poly.dto.UserInfoDTO;

import javax.servlet.http.HttpServletResponse;

public interface IUserInfoService {

    //회원가입하기
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;

    //로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
    UserInfoDTO getUserLoginCheck(UserInfoDTO pDTO) throws Exception;

    int deleteUser(UserInfoDTO pDTO) throws Exception;

    void updateUser(UserInfoDTO pDTO) throws Exception;

    //비밀번호 변경
    int updatePwSave(UserInfoDTO pDTO) throws Exception;

    //아이디 찾기
    String findId(String email) throws Exception;

    // 유저 비밀번호  변경
    int updateUserPw(UserInfoDTO pDTO) throws Exception;
}
