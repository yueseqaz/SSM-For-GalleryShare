package top.x2h.Mapper;

import org.apache.ibatis.annotations.Insert;
import top.x2h.entity.AlbumTag;

public interface AlbumTagMapper {
    @Insert("INSERT INTO album_tag (album_id, tag_id) VALUES (#{albumId}, #{tagId})")
    void insertAlbumTag(AlbumTag albumTag);
}
