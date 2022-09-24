package kopo.poly.service.impl;


import kopo.poly.dto.MailDTO;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.persistance.mapper.IUserInfoMapper;
import kopo.poly.service.IUserInfoService;
import kopo.poly.util.CmmUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;




@Slf4j
@Service("UserInfoService")
@RequiredArgsConstructor
public class UserInfoService implements IUserInfoService {

    private final IUserInfoMapper userInfoMapper;
    private final MailSender mailSender;

    //-----------------Login------------------
    @Override
    public UserInfoDTO getUserLoginCheck(UserInfoDTO pDTO) throws Exception {

        if (pDTO == null) {
            pDTO = new UserInfoDTO();
        }
        return userInfoMapper.getUserLoginCheck(pDTO);
    }



    //회원가입
    @Override
    public int insertUserInfo(UserInfoDTO pDTO) throws Exception {

        int res = 0;

        if(pDTO == null){
            pDTO = new UserInfoDTO();
        }

        //회원가입 중복 방지를 위해 DB에서 데이터 조회
        UserInfoDTO rDTO = userInfoMapper.getUserExists(pDTO);

        if (rDTO == null){
            rDTO = new UserInfoDTO();
        }

        if (CmmUtil.nvl(rDTO.getExists_yn()).equals("Y")){
            res = 2;

        }else{

            int success = userInfoMapper.InsertUserInfo(pDTO);

            if(success > 0){
                res = 1;

            }else{
                res = 0;
            }
        }

        return res;

    }



    @Transactional
    @Override
    public int deleteUser(UserInfoDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".deleteUser start!");

        int res = userInfoMapper.deleteUser(pDTO);

        return res;
    }



    @Transactional
    @Override
    public void updateUser(UserInfoDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".updateUser start!");

        userInfoMapper.updateUser(pDTO);

        log.info(this.getClass().getName() + ".updateUser end");
    }

    @Override
    public int updatePwSave(UserInfoDTO pDTO) throws Exception {
        return 0;
    }


    // 아이디 찾기
    @Override
    public String findId(String email) throws Exception {
        log.info("### service start");

        String msg = "";

        try {
            // 이메일 주소를 중심으로 나머지 정보값 가져오기(쿼리)

            log.info("email : {}", email);
            UserInfoDTO user = userInfoMapper.findId(email);
            log.info("### user : {}", user);
            log.info("### user_id : " + user.getUser_id());
            log.info("### user_email : " + user.getEmail());

            // 메일 DTO 생성
            MailDTO mailDTO = new MailDTO();

            if (user.getUser_id() == null) {
                log.info("### id null");
                msg = "이메일 전송 실패 : 이메일을 다시 확인해주세요.";
            } else {
                log.info("### id NotNull");
                // 메일 DTO에 값 넣기
                mailDTO.setAddress(email);
                mailDTO.setTitle("[Share Parking] : 아이디 찾기");
                mailDTO.setMessage("아이디 : [ " + user.getUser_id() + " ]");

                // 메일 전송을 위해 mailDTO 값을 sendMail 메소드로 보냄.
                boolean res = sendMail(mailDTO);

                msg = "이메일 전송 성공 : 이메일을 확인해 주세요.";
            }

            return msg;

        } catch (IndexOutOfBoundsException indexOutOfBoundsException) {
            msg = "이메일 전송 실패 : 이메일을 다시 확인해주세요.";
        }
        return msg;
    }

    @Override
    public int updateUserPw(UserInfoDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".changePw start!");

        return userInfoMapper.updateUserPw(pDTO);
    }

    // 메일 보내는 메소드 ( 아이디찾기 & 비밀번호 찾기 사용을 위해 뺴둠)
    public boolean sendMail(MailDTO mailDTO) throws Exception {

        log.info("### sendMail Start");

        boolean res = true;
        // 메일 전송에 = 필요한 정보 적기
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(mailDTO.getAddress());
        message.setSubject(mailDTO.getTitle());
        message.setText(mailDTO.getMessage());
        message.setFrom("gunwooidd@gmail.com");
        message.setReplyTo("gunwooidd@gmail.com");

        // 메일 보내기
        mailSender.send(message);

        return res;
    }

}





