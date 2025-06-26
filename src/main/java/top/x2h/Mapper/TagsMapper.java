package top.x2h.Mapper;

import org.apache.ibatis.annotations.Param;
import top.x2h.entity.Tags;

import java.util.List;

public interface TagsMapper {
    Integer getTagIdByName(@Param("name") String name);
    
    void insertTag(Tags tag);

    List<Tags> selectTagsByAlbumId(@Param("albumId") Integer albumId);
}
