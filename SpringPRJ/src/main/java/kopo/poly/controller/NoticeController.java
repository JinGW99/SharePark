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

    @GetMapping(value = "notice/NoticeReg")
    public String NoticeReg(){

        log.info(this.getClass().getName() + ".NoticeReg Start!");

        log.info(this.getClass().getName() + ".NoticeReg End!");

        return "/notice/NoticeReg";
    }

    @PostMapping(value = "notice/NoticeInsert")
    public String NoticeInsert(HttpSession session, HttpServletRequest request, ModelMap model) {

        log.info(this.getClass().getName() + ".NoticeInsert start!");

        String msg = "";

        try {
            String user_id = CmmUtil.nvl((String) session.getAttribute("SESSION_USER_ID"));
            String title = CmmUtil.nvl(request.getParameter("title"));
            String noticeYn = CmmUtil.nvl(request.getParameter("noticeYn"));
            String contents = CmmUtil.nvl(request.getParameter("contents"));

            log.info("user_id : " + user_id);
            log.info("title : " + title);
            log.info("noticeYn : " + noticeYn);
            log.info("contents : " + contents);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setUser_id(user_id);
            pDTO.setTitle(title);
            pDTO.setNotice_yn(noticeYn);
            pDTO.setContents(contents);

            noticeService.InsertNoticeInfo(pDTO);

            msg = "등록되었습니다";

        } catch (Exception e) {

            msg = "실패하였습니다 : " + e.getMessage();

            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeInsert End!");

            model.addAttribute("msg", msg);
        }

        return "notice/MsgToList";
    }

    @PostMapping(value = "notice/NoticeUpdate")
    public String NoticeUpdate(HttpSession session, HttpServletRequest request, ModelMap model){
        log.info(this.getClass().getName() + ".NoticeUpdate Start!");

        String msg = "";

        try{
            String user_id = CmmUtil.nvl((String) session.getAttribute("SESSION_USER_ID"));
            String nSeq = CmmUtil.nvl(request.getParameter("nSeq"));
            String title = CmmUtil.nvl(request.getParameter("title"));
            String noticeYn = CmmUtil.nvl(request.getParameter("noticeYn"));
            String contents = CmmUtil.nvl(request.getParameter("contents"));

            log.info("user_id : " + user_id);
            log.info("nSeq : " + nSeq);
            log.info("title : " + title);
            log.info("noticeYn : " + noticeYn);
            log.info("contents : " + contents);

            NoticeDTO pDTO = new NoticeDTO();

            pDTO.setUser_id(user_id);
            pDTO.setNotice_seq(nSeq);
            pDTO.setTitle(title);
            pDTO.setNotice_yn(noticeYn);
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



}
