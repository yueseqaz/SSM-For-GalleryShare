package top.x2h.Mapper;

import org.apache.ibatis.annotations.Param;
import top.x2h.entity.Album;

import java.util.List;

public interface AlbumMapper {
    List<Album> displayAllAlbum();
    void createAlbum(Album album);
    List<Album> displayAlbumByUserId(Integer userId);
    Boolean isYourAlbum(@Param("albumId") Integer albumId, @Param("userId") Integer userId);
    void deleteAlbum(Integer id);
    List<Album> adminDisplayAllAlbum();
    void changeAlbumStatus(@Param("albumId") Integer id,@Param("status") String status);
    List<Album> searchAlbumByTagKeywordAndUserId(@Param("keyword") String keyword, @Param("userId") Integer userId);
    void editAlbum(Album album);
    List<Album> selectLikedAlbumsByUserId(@Param("userId") Integer userId);



}
