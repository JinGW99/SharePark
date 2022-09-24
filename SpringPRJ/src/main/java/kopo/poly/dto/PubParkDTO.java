package kopo.poly.dto;


import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class PubParkDTO {

    private String parkingName;
    private String operationRuleNm;
    private String addrRoad;
    private String payYn;
    private String lat;
    private String lng;
}
