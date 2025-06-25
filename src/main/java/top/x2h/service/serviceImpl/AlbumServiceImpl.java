package top.x2h.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.Mapper.AlbumMapper;
import top.x2h.Mapper.PhotoMapper;
import top.x2h.entity.Album;
import top.x2h.entity.Photo;
import top.x2h.method.Sakura;
import top.x2h.service.AlbumService;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service

public class AlbumServiceImpl implements AlbumService {
    @Autowired
    private AlbumMapper albumMapper;
    @Autowired
    private PhotoMapper photoMapper;
    @Override
    public List<Album> displayAllAlbum() {
        return albumMapper.displayAllAlbum();
    }

    @Override
    public void createAlbumWithPhotos(Album album, List<MultipartFile> photos, String basePath) {

        String dateDir = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

        File dir = new File(basePath, dateDir);
        if (!dir.exists() && !dir.mkdirs()) {
            throw new RuntimeException("创建目录失败：" + dir.getAbsolutePath());
        }

        String coverUrl = null;
        List<Photo> photoList = new ArrayList<>();

        for (int i = 0; i < photos.size(); i++) {
            MultipartFile file = photos.get(i);
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File targetFile = new File(dir, fileName);

            try {
                file.transferTo(targetFile);
            } catch (IOException e) {
                throw new RuntimeException("图片保存失败", e);
            }

            String url = "/images/" + dateDir + "/" + fileName;

            if (i == 0) {
                coverUrl = url;
            }

            Photo photo = new Photo();
            photo.setUrl(url);
            photo.setDescription(file.getOriginalFilename());
            photoList.add(photo);
        }

        album.setCoverUrl(coverUrl);
        albumMapper.createAlbum(album);

        for (Photo photo : photoList) {
            photo.setAlbumId(album.getId());
            photoMapper.insertPhoto(photo);
        }
    }


    @Override
    public List<Album> displayMyAllAlbum(Integer userId) {
        return albumMapper.displayAlbumByUserId(userId);
    }


    @Override
    public boolean isYourAlbum(Integer albumId, Integer userId) {
        return  albumMapper.isYourAlbum(albumId,userId);
    }


    @Override
    public void deleteAlbum(Integer  id) {
        albumMapper.deleteAlbum(id);
    }
}
