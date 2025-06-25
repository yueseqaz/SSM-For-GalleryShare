package top.x2h.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.x2h.entity.Photo;
import top.x2h.service.PhotoService;

import java.util.List;

@Service

public class PhotoServiceImpl implements PhotoService {
    @Autowired
    private top.x2h.Mapper.PhotoMapper photoMapper;
    @Override
    public List<Photo> displayPhotoByAlbumId(Integer albumId){
        return photoMapper.displayPhotoByAlbumId(albumId);
    }
}
