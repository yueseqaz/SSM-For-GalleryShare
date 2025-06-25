package top.x2h.entity;

import lombok.Data;
@Data

public class Photo {
    private Integer id;
    private Integer albumId;
    private String url;
    private String description;
    private String uploadTime;

}
