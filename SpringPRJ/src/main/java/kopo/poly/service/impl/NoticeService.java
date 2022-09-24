package kopo.poly.service.impl;

import kopo.poly.dto.NoticeDTO;
import kopo.poly.persistance.mapper.INoticeMapper;
import kopo.poly.service.INoticeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service("NoticeService")
public class NoticeService implements INoticeService {

    private final INoticeMapper noticeMapper;

    @Autowired
    public NoticeService(INoticeMapper noticeMapper){
        this.noticeMapper = noticeMapper;
    }

    @Override
    public List<NoticeDTO> getNoticeList() throws Exception {
        return noticeMapper.getNoticeList();
    }

    @Transactional
    @Override
    public void InsertNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertNotice Start!");

        noticeMapper.InsertNoticeInfo(pDTO);

    }

    @Transactional
    @Override
    public NoticeDTO getNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getNoticeInfo start");

        log.info("Update ReadCnt");
        noticeMapper.updateNoticeReadCnt(pDTO);

        return noticeMapper.getNoticeInfo(pDTO);
    }

    @Transactional
    @Override
    public void updateNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".updateNoticeInfo Start!");

        noticeMapper.updateNoticeInfo(pDTO);
    }


    @Transactional
    @Override
    public void deleteNoticeInfo(NoticeDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".deleteNoticeInfo Start!");

        noticeMapper.deleteNoticeInfo(pDTO);
    }
}
