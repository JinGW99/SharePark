package kopo.poly.controller;

import kopo.poly.dto.NoticeDTO;
import kopo.poly.service.INoticeService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class NoticeController {

    @Resource(name = "NoticeService")
    private INoticeService noticeService;

    @GetMapping(value = "notice/NoticeList")
    public String NoticeList(ModelMap model)
        throws Exception{

        log.info(this.getClass().getName() + ".NoticeList start!");

        List<NoticeDTO> rList = noticeService.getNoticeList();

        if (rList == null){
            rList = new ArrayList<>();
        }

        model.addAttribute("rList", rList);

        log.info(this.getClass().getName() + ".NoticeList End!");

        return "/notice/NoticeList";
    }

    //게시글 등록 페이지로 이동
    @GetMapping(value = "notice/NoticeReg")
    public String NoticeReg(HttpSession session, HttpServletRequest request, ModelMap model){

        log.info(this.getClass().getName() + ".NoticeReg Start!");

        log.info(this.getClass().getName() + ".NoticeReg End!");

        return "/notice/NoticeReg";
    }

    //게시글 등록 로직
    @PostMapping(value = "notice/NoticeInsert")
    public String NoticeInsert(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeInsert start!");

        String msg = "";
        String url = "";

        try {
            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
            String title = CmmUtil.nvl(request.getParameter("title"));
            String contents = CmmUtil.nvl(request.getParameter("contents"));

            log.info("user_id : " + user_id);
            log.info("title : " + title);
            log.info("contents : " + contents);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setUser_id(user_id);
            pDTO.setTitle(title);
            pDTO.setContents(contents);

            noticeService.InsertNoticeInfo(pDTO);

            msg = "등록되었습니다";
            url = "notice/NoticeList";

        } catch (Exception e) {

            msg = "실패하였습니다 : " + e.getMessage();
            url = "notice/NoticeList";

            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeInsert End!");

            model.addAttribute("url", url);
            model.addAttribute("msg", msg);

            log.info("model : " + model);
        }

        return "/notice/MsgToList";
    }

    //게시글 상세보기
    @GetMapping(value = "notice/NoticeInfo")
    public String NoticeInfo(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeInfo Start!");

        String msg = "";

        try {
            String notice_seq = CmmUtil.nvl(request.getParameter("notice_seq"));

            log.info("notice_seq : " + notice_seq);

            NoticeDTO pDTO = new NoticeDTO();
            pDTO.setNotice_seq(notice_seq);

            NoticeDTO rDTO = noticeService.getNoticeInfo(pDTO);

            if (rDTO == null){
                rDTO = new NoticeDTO();
            }
            log.info("getNotice success");

            model.addAttribute("rDTO", rDTO);

        }catch (Exception e) {
            msg = "실패하였습니다. : " +  e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        }finally {
            log.info(this.getClass().getName() + ".NoticeInfo End!");

            model.addAttribute("msg", msg);
        }

        return "notice/NoticeInfo";
    }

    //게시글 수정으로 이동
    @GetMapping(value = "notice/NoticeEditInfo")
    public String NoticeEditInfo(HttpSession session, HttpServletRequest request, ModelMap model){

        log.info(this.getClass().getName() + ".NoticeReg Start!");

        log.info(this.getClass().getName() + ".NoticeReg End!");

        return "/notice/NoticeEditInfo";
    }

    //게시글 수정
    @PostMapping(value = "notice/NoticeUpdate")
    public String NoticeUpdate(HttpSession session, HttpServletRequest request, ModelMap model){
        log.info(this.getClass().getName() + ".NoticeUpdate Start!");

        String msg = "";

        try{
            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
            String notice_seq = CmmUtil.nvl(request.getParameter("notice_seq"));
            String title = CmmUtil.nvl(request.getParameter("title"));
            String contents = CmmUtil.nvl(request.getParameter("contents"));

            log.info("user_id : " + user_id);
            log.info("notice_seq : " + notice_seq);
            log.info("title : " + title);
            log.info("contents : " + contents);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setUser_id(user_id);
            pDTO.setNotice_seq(notice_seq);
            pDTO.setTitle(title);
            pDTO.setContents(contents);

            noticeService.updateNoticeInfo(pDTO);

            msg = "수정되었습니다";

        }catch (Exception e){
            msg = "실패하였습니다 : " + e.getMessage();
            log.info(e.toString());
            e.printStackTrace();

        }finally {
            log.info(this.getClass().getName() + ".NoticeUpdate end");

            model.addAttribute("msg", msg);
        }

        return "/notice/MsgToList";
    }


    //게시글 삭제
    @GetMapping(value = "notice/NoticeDelete")
    public String NoticeDelete(HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeDelete Start!");

        String msg = "";

        try{

            String notice_seq = CmmUtil.nvl(request.getParameter("notice_seq"));

            log.info("notice_seq : " + notice_seq);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setNotice_seq(notice_seq);

            noticeService.deleteNoticeInfo(pDTO);

            msg = "삭제되었습니다";

        }catch (Exception e){
            msg = "실패하였습니다 : " + e.getMessage();

            log.info(e.toString());
            e.printStackTrace();

        }finally {
            log.info(this.getClass().getName() + ".NoticeDelete End!");

            model.addAttribute("msg", msg);

        }
        return "notice/MsgToList";
    }



}
