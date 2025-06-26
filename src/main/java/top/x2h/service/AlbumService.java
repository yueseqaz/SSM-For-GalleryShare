package top.x2h.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.entity.Album;

import java.util.List;

@Service

public interface AlbumService {

    List<Album> displayAllAlbum();
    void createAlbumWithPhotos(Album album, List<MultipartFile> photos,String basePath,List<String> tagsName);
    List<Album> displayMyAllAlbum(Integer userId);
    boolean isYourAlbum(Integer albumId,Integer userId);
    void deleteAlbum(Integer id);
    List<Album> adminDisplayAllAlbum();
    void changeAlbumStatus(Integer id,String status);
    List<Album> searchAlbumByTagKeywordAndUserId(String keyword, Integer userId);
    void editAlbum(Album album);
    List<Album> getLikedAlbumsByUserId(Integer userId);

}
