package top.x2h.Mapper;

import org.apache.ibatis.annotations.Param;

public interface LikeMapper {
    void like(@Param("albumId") Integer albumId, @Param("userId") Integer userId);
    Integer count(@Param("albumId") int albumId);
    Integer isLiked(@Param("albumId") int albumId, @Param("userId") int userId);

}
