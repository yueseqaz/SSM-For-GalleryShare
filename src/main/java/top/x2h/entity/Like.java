package top.x2h.entity;
import lombok.Data;
@Data
public class Like {
    private Integer id;
    private Integer userId;
    private Integer albumId;
    private String createTime;
}
