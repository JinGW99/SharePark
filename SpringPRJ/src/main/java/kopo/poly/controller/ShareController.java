package kopo.poly.controller;


import kopo.poly.dto.ShareDTO;
import kopo.poly.service.IShareService;
import kopo.poly.service.IImgService;
import kopo.poly.service.IS3Service;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class ShareController extends AbstractImgUpload {

    @Resource(name = "ShareService")
    private IShareService shareService;


    //-------주차장 등록페이지로 이동-------
    @RequestMapping(value = "/Share/RegPark")
    public String ShareRegPark(HttpSession session, HttpServletRequest request)
    {
        return "/Share/RegTest";
    }

    

//-----공유내역 보기------
    @GetMapping(value = "PRJ/myPage3")
    public String ShareList(HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {


        log.info(this.getClass().getName() + ".ShareList start");

        // 세션 아이디를 가지고 온다.
        String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        log.info("### session_userId : {}", user_id);

        // 주차장 정보와 이미지 정보를 매핑시켜 가져온다.
        List<ShareDTO> rList = shareService.getShareList(user_id);


        if (rList == null) {
            log.info("### null 체크 당함");
            rList = new ArrayList<>();
        } else if (rList.size() == 0){
            log.info("사이즈 없습니다.");
            model.addAttribute("msg", "공유된 내역이 없습니다.");
            model.addAttribute("url", "/PRJmain");
            return "/redirect";
        }
        log.info("### rList : {}", rList);
        log.info("### rList.index : {}", rList.get(0));

        for (ShareDTO shareDTO : rList) {
            log.info("### shareDTO : {}", shareDTO);
        }

        model.addAttribute("rList", rList);


        log.info("rList" + rList);


        log.info(this.getClass().getName() + "ShareList end");

        return "/PRJ/myPage3";
    }

//공유주차장 보기
    @GetMapping(value = "spMap_test")
    public String test(HttpSession session, HttpServletRequest request, ModelMap model) throws Exception{

        log.info(this.getClass().getName() + ".ShareListAll start");

        String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        String sp_seq = CmmUtil.nvl(request.getParameter("sp_seq"));

        List<ShareDTO> rList = shareService.getShareListAll();

        if (rList == null){
            rList = new ArrayList<>();
        }

        model.addAttribute("rList", rList);

        log.info("rList :" + rList);

        log.info(this.getClass().getName() + ".ShareListALl end");

        return "/PRJ/spMap";

    }

    //주차장 상세보기
    @GetMapping(value = "share/ParkInfo")
    public String ParkInfo(HttpServletRequest request, ModelMap model, HttpSession session){

        log.info(this.getClass().getName() + ".ParkInfo start!");

        String msg="";

        try{

            String sp_seq = CmmUtil.nvl(request.getParameter("sp_seq"));
            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

            log.info("sp_seq :" + sp_seq);

            ShareDTO pDTO = new ShareDTO();
            pDTO.setSp_seq(sp_seq);
            pDTO.setUser_id(user_id);
            log.info(pDTO.getSp_seq());

            ShareDTO rDTO = shareService.getParkInfo(pDTO);

            if (rDTO == null){
                rDTO = new ShareDTO();
            }
            log.info(rDTO.getSp_seq());
            log.info("rDTO222 : " + rDTO.getSave_file_path());
            log.info("### rDTO.reser_id : " + rDTO.getReser_id());
            log.info(this.getClass().getName() + ".getParkInfo success");


            model.addAttribute("rDTO", rDTO);

            log.info(this.getClass().getName() + ".ParkInfo end");


        }catch (Exception e){

            msg = "fail :" +e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        }
        return "Share/ParkInfo";
    }

    @GetMapping("share/ParkEditInfo")
    public String ParkUpdatepage(HttpSession session, HttpServletRequest request, ModelMap model){

        log.info(this.getClass().getName() + ".ParkEditInfo start");

        String msg = "";

        try {
            String sp_seq = CmmUtil.nvl(request.getParameter("sp_seq"));

            log.info("sp_seq" + sp_seq);

            ShareDTO pDTO = new ShareDTO();
            pDTO.setSp_seq(sp_seq);

            ShareDTO rDTO = shareService.getParkInfo(pDTO);
            if (rDTO == null){
                rDTO = new ShareDTO();
            }

            log.info("### rDTO : {}", rDTO);
            log.info("### rDTO.path : {}", rDTO.getSave_file_path());
            log.info("### rDTO.seq : {}", rDTO.getSp_seq());



            log.info(this.getClass().getName() + ".SharePark Update emd");

            model.addAttribute("msg", msg);
            model.addAttribute("rDTO", rDTO);

            return "/Share/ParkEditInfo";

        }catch (Exception e){
            msg = "실패" + e.getMessage();

            log.info(e.toString());
            e.printStackTrace();

        }

        return "/Share/ParkEditInfo";
    }

//주차장 수정
    @RequestMapping(value = "share/ParkUpdate")
    public String ParkUpdate(HttpSession session, HttpServletRequest request, ModelMap model)
    throws Exception{

        log.info(this.getClass().getName() + "Parkupdate start");


        String msg = "";
        String url = "";


        try {
            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
            String sp_seq = CmmUtil.nvl(request.getParameter("sp_seq"));
            String sp_title = CmmUtil.nvl(request.getParameter("sp_title"));
            String sp_contents = CmmUtil.nvl(request.getParameter("sp_contents"));
            String start_time = CmmUtil.nvl(request.getParameter("start_time"));
            String end_time = CmmUtil.nvl(request.getParameter("end_time"));
            String sp_place = CmmUtil.nvl(request.getParameter("sp_place"));
           

            log.info("user_id :" + user_id);
            log.info("sp_seq :" + sp_seq);
            log.info("sp_title :" + sp_title);
            log.info("sp_contents : " + sp_contents);
            log.info("start_time: " + start_time);
            log.info("end_time : " + end_time);
            log.info("sp_place: " + sp_place);

            ShareDTO pDTO = new ShareDTO();

            pDTO.setUser_id(user_id);
            pDTO.setSp_seq(sp_seq);
            pDTO.setSp_title(sp_title);
            pDTO.setSp_contents(sp_contents);
            pDTO.setStart_time(start_time);
            pDTO.setEnd_time(end_time);
            pDTO.setSp_place(sp_place);

            shareService.updateParkInfo(pDTO);

            msg = "수정되었습니다";
            url = "/PRJ/PRJmain";
        }catch (Exception e){
            msg = "fail :" + e.getMessage();
            url = "/PRJ/PRJmain";
            log.info(e.toString());
            e.printStackTrace();;
        }finally {
            log.info(this.getClass().getName() + ".Update end");

            model.addAttribute("msg", msg);
            model.addAttribute("url", url);
        }

        return "/redirect";
    }

    //공유주차장 삭제
    @GetMapping(value = "share/ParkDelete")
    public String ParkDelete(HttpServletRequest request, ModelMap model){

        log.info(this.getClass().getName() + ".delete staert");

        String msg = "";
        String url = "";

        try{

            String sp_seq = CmmUtil.nvl(request.getParameter("sp_seq"));

            log.info("sp_seq" + sp_seq);

            ShareDTO pDTO = new ShareDTO();

            pDTO.setSp_seq(sp_seq);

            shareService.deleteParkInfo(pDTO);

            msg = "삭제 완료";
            url = "/PRJmain";

        }catch (Exception e){
            msg = "삭제 실패" + e.getMessage();
            log.info(e.toString());

        }finally {
            log.info(this.getClass().getName() + ".delete end");

            model.addAttribute("msg", msg);
            model.addAttribute("url", url);
        }

        return "redirect";
    }



    //예약로직
    @RequestMapping(value = "share/reservation")
    public String Reservation(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                              ModelMap model)throws Exception{

        String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

        log.info(this.getClass().getName() + ".reservation start");
        String reser_id = CmmUtil.nvl(request.getParameter("reser_id"));

        if (reser_id.length() > 1) {
            model.addAttribute("msg", "예약 불가능");
            model.addAttribute("url", "/PRJmain");
            return "/redirect";
        }

        String msg = "";
        String url = "";

        try{


            String sp_seq = CmmUtil.nvl(request.getParameter("sp_seq"));

            log.info("reser_id : {}", reser_id);
            log.info("user_id :" + user_id);
            log.info("sp_seq : " + sp_seq);

            ShareDTO pDTO = new ShareDTO();

            pDTO.setReser_id(user_id);
            pDTO.setSp_seq(sp_seq);

            int res = shareService.Reservation(pDTO);

            log.info("res :" + res);

            msg = "예약 성공";
            url = "/PRJmain";


        }catch (Exception e){
            msg = "예약 실패" + e.getMessage();
            url = "/spMap_test";
            log.info(e.toString());
            e.printStackTrace();

        }finally {
            log.info(this.getClass().getName() + ".Reserv end");

            model.addAttribute("url", url);
            model.addAttribute("msg",msg);

        }

        return "/redirect";
    }


    @GetMapping("deleteReser")
    public String deleteReser(HttpServletRequest request, ModelMap model) throws Exception{

        log.info(this.getClass().getName() + ".deleteReser start");

        String msg = "";
        String url = "";

        try {
            String sp_seq = CmmUtil.nvl(request.getParameter("sp_seq"));

            log.info("sp_seq :" + sp_seq);

            ShareDTO pDTO = new ShareDTO();

            pDTO.setSp_seq(sp_seq);

            shareService.deleteReser(pDTO);

            msg = "예약이 취소되었습니다";
            url = "/PRJmain";

        }catch (Exception e){

            msg = "예약 취소를 실패하였습니다"+ e.getMessage();
            url = "/PRJmain";
            log.info(e.toString());
            e.printStackTrace();;

        }finally {
            model.addAttribute("msg", msg);
            model.addAttribute("url", url);
        }
        return "/redirect";
    }


}
