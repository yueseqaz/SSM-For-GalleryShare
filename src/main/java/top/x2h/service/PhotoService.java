package top.x2h.service;

import org.springframework.stereotype.Service;
import top.x2h.entity.Photo;

import java.util.List;

@Service
public interface PhotoService {
    List<Photo> displayPhotoByAlbumId(Integer albumId);

}
