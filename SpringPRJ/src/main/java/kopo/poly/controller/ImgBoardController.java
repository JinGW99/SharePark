package kopo.poly.controller;



import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.*;

import kopo.poly.dto.ImgDTO;
import kopo.poly.dto.ShareDTO;
import kopo.poly.service.IImgService;
import kopo.poly.service.IS3Service;
import kopo.poly.service.IShareService;
import kopo.poly.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Slf4j
@Controller("ImgBoardController")
public class ImgBoardController extends AbstractImgUpload {

    /*

     * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
     */
    @Resource(name = "ShareService")
    private IShareService shareService;

    @Resource(name = "ImgService")
    private IImgService imgService;

    //이미지 서비스 활용
    @Resource(name = "S3Service")
    private IS3Service s3Service;



    // 게시판 정보 등록하기
    @RequestMapping (value = "boardInsert")
    public String boardInsert(HttpSession session, HttpServletRequest request, ModelMap model,
                               @RequestParam(value = "pro_image", required = false) MultipartFile mf) throws Exception {

        log.info(getClass().getName() + ". boardInsert Start");

        log.info("mf : " +mf);

        String msg = "";
        String url = "";


        String Originalname = mf.getOriginalFilename();

        log.info("파일이 옵니까?" + Originalname);


        if (mf != null) {
           int result = super.ImgUpload(session, mf);
           log.info("이미지 사진등록이 완료되어있으면 1입니다." + result);
        }


        try {
            /*
             * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
             */
            String sp_title = CmmUtil.nvl(request.getParameter("sp_title")); // 제목
            String sp_contents = CmmUtil.nvl(request.getParameter("sp_contents")); // 내용
            String sp_place = CmmUtil.nvl(request.getParameter("sp_place")); // 내용
            String start_time = CmmUtil.nvl(request.getParameter("start_time")); // 내용
            String end_time = CmmUtil.nvl(request.getParameter("end_time")); // 내용
            String reg_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));

            /*
             * ####################################################################################
             * 반드시, 값을 받았으면, 꼭 로그를 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
             * ####################################################################################
             */
            log.info("sp_title : " + sp_title);
            log.info("sp_contents : " + sp_contents);
            log.info("sp_place : " + sp_place);
            log.info("start_time : " + start_time);
            log.info("end_time : " + end_time);
            log.info("reg_id : " + reg_id);

            ShareDTO pDTO = new ShareDTO();

            pDTO.setSp_title(sp_title);
            pDTO.setSp_contents(sp_contents);
            pDTO.setSp_place(sp_place);
            pDTO.setStart_time(start_time);
            pDTO.setEnd_time(end_time);
            pDTO.setReg_id(CmmUtil.nvl((String) session.getAttribute("SS_USER_ID")));
            pDTO.setReg_dt(reg_id);
            pDTO.setUser_id(user_id);


            /*
             * 게시글 등록하기위한 비즈니스 로직을 호출
             */
            int res = shareService.InsertShare(pDTO);

            log.info(this.getClass().getName() + res);

            pDTO = null;

            // 저장이 완료되면 사용자에게 보여줄 메시지
            msg = "등록되었습니다.";
            url = "/PRJmain";


        } catch (Exception e) {

            // 저장이 실패되면 사용자에게 보여줄 메시지
            msg = "실패하였습니다. : " + e.getMessage();
            url = "/Share/RegPark";
            log.info(e.toString());
            e.printStackTrace();

        } finally {
            log.info(this.getClass().getName() + ".NoticeInsert end!");

            // 결과 메시지 전달하기
            model.addAttribute("msg", msg);
            model.addAttribute("url", "/PRJmain");

        }


        log.info(getClass().getName() + ". boardInsert End ");
        return "/redirect";

    }

}
