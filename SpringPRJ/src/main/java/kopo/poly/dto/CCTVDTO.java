package kopo.poly.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;



@JsonInclude(JsonInclude.Include.NON_NULL)
@Data

public class CCTVDTO {
    private String no;
    private String lot;
    private String lat;
    private String addr;
    private String data;

}
