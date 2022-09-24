package kopo.poly.persistance.mapper;

        import kopo.poly.dto.ImgDTO;
        import kopo.poly.dto.ShareDTO;
        import org.apache.ibatis.annotations.Mapper;
        import java.util.List;

@Mapper
public interface IShareMapper {

    //주차장 등록
    int InsertShare(ShareDTO pDTO) throws Exception;

    //내꺼만 주차장 리스트
    List<ShareDTO> getShareList(String user_id) throws Exception;

    //전체 주차장 리스트
    List<ShareDTO> getShareListAll() throws Exception;

    //주차장 상세보기
    ShareDTO getParkInfo(ShareDTO pDTO) throws Exception;

    //주차장 글 수정
    void updateParkInfo(ShareDTO pDTO) throws Exception;

    //주차장 삭제
    void deleteParkInfo(ShareDTO pDTO) throws Exception;

    //예약
    int Reservation(ShareDTO pDTO) throws Exception;

    //회원가입 전 중복체크하기
    ShareDTO getReserExists(ShareDTO pDTO) throws Exception;

    //예약한 리스트 가져오기
    List<ShareDTO> reserPark(String user_id) throws Exception;

    void deleteReser(ShareDTO pDTO) throws Exception;

    int InsertTitle(ImgDTO iDTO) throws Exception;

}
