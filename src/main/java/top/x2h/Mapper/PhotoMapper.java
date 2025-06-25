package top.x2h.Mapper;

import top.x2h.entity.Photo;

import java.util.List;

public interface PhotoMapper {
    void insertPhoto(Photo  photo);
    List<Photo> displayPhotoByAlbumId(Integer albumId);
}
