package top.x2h.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.entity.Album;

import java.util.List;

@Service

public interface AlbumService {

    List<Album> displayAllAlbum();
    void createAlbumWithPhotos(Album album, List<MultipartFile> photos,String basePath);
    List<Album> displayMyAllAlbum(Integer userId);
    boolean isYourAlbum(Integer albumId,Integer userId);
    void deleteAlbum(Integer id);
}
