package top.x2h.entity;
import lombok.Data;

import java.util.List;

@Data

public class Album {
    private Integer id;
    private Integer userId;
    private String title;
    private  String description;
    private  String coverUrl;
    private String createTime;
    private String status;
    private User user;
    private List<Tags> tags;
}
