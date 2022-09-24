package kopo.poly.persistance.mapper;


import kopo.poly.dto.UserInfoDTO;


import org.apache.ibatis.annotations.Mapper;



import java.util.List;

@Mapper
public interface

IUserInfoMapper {

    List<UserInfoDTO> getNoticeList() throws Exception;

    //회원가입하기
    int InsertUserInfo(UserInfoDTO pDTO) throws Exception;

    //회원가입 전 중복체크하기
    UserInfoDTO getUserExists(UserInfoDTO pDTO) throws Exception;

    //로그인을 위해 아이디와 비밀번호가 일치하는지 확인하기
    UserInfoDTO getUserLoginCheck(UserInfoDTO pDTO) throws Exception;

    //회원탈퇴
    int deleteUser(UserInfoDTO pDTO) throws Exception;

    //회원정보 수정
    void updateUser(UserInfoDTO pDTO) throws Exception;

    //사용자 Id 찾기
    UserInfoDTO findUserId(UserInfoDTO pDTO);

    //사용자 정보가져오기
    List<UserInfoDTO> getUserList(UserInfoDTO pDTO);

    //비밀번호 수정
    int updatePwSave(UserInfoDTO pDTO) throws Exception;

    //아이디 찾기
    UserInfoDTO findId(String email) throws Exception;

    // 유저 비밀번호  변경
    int updateUserPw(UserInfoDTO pDTO) throws Exception;
}
