package top.x2h.entity;
import lombok.Data;
@Data

public class Album {
    private Integer id;
    private Integer userId;
    private String title;
    private  String description;
    private  String coverUrl;
    private String createTime;
    private String status;

}
