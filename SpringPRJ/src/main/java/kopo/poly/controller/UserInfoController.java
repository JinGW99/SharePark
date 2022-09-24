package kopo.poly.controller;

import kopo.poly.dto.ShareDTO;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.service.IShareService;
import kopo.poly.service.IUserInfoService;

import kopo.poly.util.CmmUtil;
import kopo.poly.util.EncryptUtil;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

import java.util.List;



@Slf4j
@Controller
public class UserInfoController {

    private IUserInfoService userInfoService;


    @Autowired
    public void UserInfoService(IUserInfoService userInfoService) {this.userInfoService = userInfoService;}


    @Resource(name = "ShareService")
    private IShareService shareService;


     //--------------------------------------회원가입 페이지로 이동----------------------------

    @RequestMapping(value = "PRJ/userRegForm")
    public String userRegFrom(){
        log.info(this.getClass().getName() + ".user/userRegForm ok!");

        return "/PRJ/userRegForm";
    }


     //--------------------------- 회원가입 로직----------------------------------------

    @RequestMapping(value = "user/insertUserInfo",method = RequestMethod.POST)
    public String insertUserInfo (HttpServletRequest request, HttpServletResponse response,
                                  ModelMap model) throws Exception{

        log.info(this.getClass().getName() + ".insertUserInfo start!");

        String msg = "";
        String url = "";

        UserInfoDTO pDTO = null;


        try{

            String user_id = CmmUtil.nvl(request.getParameter("user_id"));
            String password = CmmUtil.nvl(request.getParameter("password"));
            String email = CmmUtil.nvl(request.getParameter("email"));
            String address = CmmUtil.nvl(request.getParameter("address"));
            String user_phone = CmmUtil.nvl(request.getParameter("user_phone"));

            log.info("user_id :" + user_id);
            log.info("password :" + password);
            log.info("email :" + email);
            log.info("address :" + address);
            log.info("user_phone :" + user_phone);

            pDTO = new UserInfoDTO();

            pDTO.setUser_id(user_id);
            pDTO.setPassword(EncryptUtil.encHashSHA256(password));
            pDTO.setEmail(email);
            pDTO.setAddress(address);
            pDTO.setUser_phone(user_phone);

            int res = userInfoService.insertUserInfo(pDTO);

            if (res==1){
                msg = "회원가입 되었습니다";
                url = "/PRJ/loginForm";
            }else if(res==2) {
                msg = "이미 가입된 이메일 주소입니다";
                url = "/PRJ/userRegForm";
            }else{
                msg = "오류로 인해 회원가입이 실패하였습니다";
                url = "/PRJ/userRegForm";
            }

        }catch (Exception e){
            //저장 시류ㅐ시 사용자에게 보여줄 메시지
            msg = "실패하였습니다 : " + e.toString();
            log.info(e.toString());
            e.printStackTrace();

        }finally {
            log.info(this.getClass().getName() + ".insertUserInfo end!");

            model.addAttribute("msg", msg);
            model.addAttribute("url", url);
            model.addAttribute("pDTO", pDTO);

            pDTO = null;
        }

        return "/redirect";
    }

    //---------------------로그인을 위한 입력 화면으로 이동-----------------------
    @RequestMapping(value = "PRJ/loginForm")
    public String loginForm(){
        log.info(this.getClass().getName() + ".user/loginForm ko!");

        return "/PRJ/PRJLogin";
    }


    //-------------------------로그인 처리 및 결과 알려주는 화면-------------------------
    @PostMapping(value = "PRJ/getUserLoginCheck")
    public String getUserLoginCheck(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                                    ModelMap model) throws Exception{
        log.info(this.getClass().getName() + ".getUserLoginCheck start!");

        String msg = "";
        String url = "";

        try{

            String user_id = CmmUtil.nvl(request.getParameter("user_id"));
            String password = CmmUtil.nvl(request.getParameter("password"));
            String email = CmmUtil.nvl(request.getParameter("email"));
            String user_phone = CmmUtil.nvl(request.getParameter("user_phone"));
            String address = CmmUtil.nvl(request.getParameter("address"));

            log.info("user_id : " + user_id);
            log.info("password : " + password);

            UserInfoDTO pDTO = new UserInfoDTO();

            pDTO.setUser_id(user_id);
            pDTO.setPassword(EncryptUtil.encHashSHA256(password));
            pDTO.setEmail(email);
            pDTO.setUser_phone(user_phone);
            pDTO.setAddress(address);

            UserInfoDTO rDTO = userInfoService.getUserLoginCheck(pDTO);

            if (rDTO == null){
                rDTO = new UserInfoDTO();
                msg = "아이디 / 비밀번호를 확인해주세요";
                url = "/PRJ/loginForm";
            }else {
                msg = "로그인 성공";
                url = "/PRJmain";
                
                //session에 저장
                session.setAttribute("SS_USER_ID", rDTO.getUser_id());
                session.setAttribute("SS_USER_SEQ", rDTO.getUser_seq());
                session.setAttribute("SS_USER_PHONE",rDTO.getUser_phone());
                session.setAttribute("SS_ADDRESS",rDTO.getAddress());

                log.info("SS_USER_ID : " + rDTO.getUser_id());
                log.info("SS_USER_SEQ : " + rDTO.getUser_seq());
                log.info("SS_USER_PHONE :" + rDTO.getUser_phone());
                log.info("SS_ADDRESS :" + rDTO.getAddress());
            }
            rDTO = null;

        }catch (Exception e){
            msg = "실패하였습니다 :" + e.toString();
            System.out.println("오류로 인해 로그인이 실패하였습니다");
            log.info(e.toString());
            e.printStackTrace();
        }finally {
            log.info(this.getClass().getName() + ".insertUser end!");
            model.addAttribute("msg", msg);
            model.addAttribute("url", url);
        }
        return "/redirect";
    }

    //-----------------------로그아웃--------------------------
    @RequestMapping(value = "PRJ/Logout")
    public String Logout(HttpServletRequest request, ModelMap model) {
        log.info(this.getClass().getName() + ".Logout start!");
        HttpSession session = request.getSession();

        String url = "/PRJ/loginForm";
        String msg = "로그아웃 성공";
        session.invalidate(); // session clear
        model.addAttribute("msg", msg);
        model.addAttribute("url", url);
        return "/redirect";
    }


    //----------------------회원탈퇴-----------------------------------
    @GetMapping(value = "PRJ/deleteUser")
    public String deleteUser(HttpSession session, HttpServletResponse response,HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".deleteUser start!");

        String msg = "";
        String url = "";

        try {

//            String user_seq = CmmUtil.nvl(request.getParameter("user_seq"));
            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));


            log.info("user_id :" + user_id);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_id(user_id);

            int res= userInfoService.deleteUser(pDTO);

            log.info("res  :" + res);
            msg = "회원탈퇴에 성공하였습니다";
            url = "/PRJ/loginForm";

            session.invalidate(); // session clear


        } catch (Exception e) {
            msg = "회원탈퇴 실패 : " + e.getMessage();
            url = "/PRJmain";
            log.info(e.toString());
            e.printStackTrace();
        } finally {
            log.info(this.getClass().getName() + ".deleteUser end!");

            model.addAttribute("msg", msg);
            model.addAttribute("url", url);


        }

        return "/redirect";
    }

    //-----------------회원정보 보기---------------
    @RequestMapping(value = "/PRJ/myPage")
    public String MyPage(){
        return "/PRJ/myPage1";
    }


    //--------------------예약내역 보기----------------
    @RequestMapping(value = "/PRJ/myPage2")
    public String MyPage2(HttpSession session, HttpServletRequest request, ModelMap model)throws Exception
    {

        log.info(this.getClass().getName() + ".ReserPark start");

        String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        log.info("### session_user_id : {}", user_id);

        List<ShareDTO> rList = shareService.reserPark(user_id);

        if (rList == null){
            rList = new ArrayList<>();
        }

        for (ShareDTO shareDTO : rList){
            log.info("### shareDTO : {}", shareDTO);
        }

        model.addAttribute("rList", rList);

        log.info("rList : " + rList);

        log.info(this.getClass().getName() + "ReserEnd");

        return "/PRJ/myPage2";
    }



    //----------------회원정보 수정으로 이동--------------
    @RequestMapping(value = "/PRJ/updateUserMove")
    public String updateUserMove(HttpSession session, HttpServletRequest request, ModelMap model)
    {return "/PRJ/updateUser";}


    //--------------------회원정보 수정----------------
    @RequestMapping(value = "PRJ/updateUser")
    public String updateUser(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".userUpdate start!");

        String msg = "";
        String url = "";

        try {

            String user_seq = CmmUtil.nvl(request.getParameter("user_seq"));
            String address = CmmUtil.nvl(request.getParameter("address"));
            String user_phone = CmmUtil.nvl(request.getParameter("user_phone"));


            log.info("user_seq:" + user_seq);
            log.info("address:" + address);
            log.info("user_phone:" + user_phone);

            UserInfoDTO pDTO = new UserInfoDTO();

            pDTO.setUser_seq(user_seq);
            pDTO.setAddress(address);
            pDTO.setUser_phone(user_phone);

            userInfoService.updateUser(pDTO);

            msg = "수정되었습니다";
            url = "/PRJ/myPage";

            session.setAttribute("SS_USER_PHONE",pDTO.getUser_phone());
            session.setAttribute("SS_ADDRESS",pDTO.getAddress());
        }catch (Exception e){

            msg = "수정 실패";
            url = "/PRJ/myPage";
            log.info("수정 실패" + e.getMessage());
            e.printStackTrace();
        }finally {
            log.info(this.getClass().getName() + ".UserUpdate end");

            model.addAttribute("msg",msg);
            model.addAttribute("url",url);
        }

        log.info("url:" + url);

        return "/redirect";
    }

    // 아이디 찾기 페이지
    @GetMapping("findId/page")
    public String findIdPage() {
        return "/PRJ/findId";
    }

    // 아이디 찾기 로직
    @PostMapping("findId")
    public String findIdPage(HttpServletRequest request, Model model) throws Exception {

        log.info(this.getClass().getName() + ".FIND_ID START");

        // view에서 id를 email로 이메일을 input에 담아 보내줌
        String email = request.getParameter("email");

        log.info("email : " +email);

        // 메일을 전송하는 로직을 타고, 성공, 실패 여부를 String으로 받아온다.
        String msg = userInfoService.findId(email);

        // 성공 여부를 알려주는 alert
        model.addAttribute("msg", msg);
        model.addAttribute("url", "/PRJ/loginForm");

        return "/redirect";
    }

    @GetMapping("updatePwPage")
    public String updatePwPage(HttpServletRequest request, HttpSession session){
        return "/PRJ/ChangePW";
    }

    // 사용자 패스워드 바꾸기
    @RequestMapping(value = "updateUserPw")
    public String updateUserPw(HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".updateUserPw start");

        String msg = "";
        String url = "";

        try {

            // 이메일 AES-128-CBC 암호화
            String email = EncryptUtil.encAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_USER_EMAIL")));

            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

            // 비밀번호 해시 알고리즘 암호화
            String password = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("password")));

            log.info("email : " + email);
            log.info("password : " + password);
            log.info("user_id : " + user_id);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setEmail(email);
            pDTO.setUser_id(user_id);
            pDTO.setPassword(password);

            int res = userInfoService.updateUserPw(pDTO);

            log.info("res :" + res);

            if (res > 0) {
                msg = "비밀번호 변경!! 다시 로그인 해주세요";
                url = "/PRJ/loginForm";
            } else {
                msg = "비밀번호 저장에 실패했습니다.";
                url = "/updatePwPage";
            }

        } catch (Exception e) {
            // 저장 실패 시
            msg = "서버 오류입니다.";
            url = "/updatePwPage";
            log.info(e.toString());
            e.printStackTrace();
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".updateUserPw end");

        return "/redirect";
    }








}
