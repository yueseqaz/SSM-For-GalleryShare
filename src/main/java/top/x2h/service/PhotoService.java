package top.x2h.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.entity.Photo;

import java.util.List;

@Service
public interface PhotoService {
    List<Photo> displayPhotoByAlbumId(Integer albumId);
    void addPhotosToAlbum(int albumId, List<MultipartFile> photos, String basePath);
    void deletePhoto(Integer id);

}
