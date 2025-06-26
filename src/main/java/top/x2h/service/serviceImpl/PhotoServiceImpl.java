package top.x2h.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.Mapper.PhotoMapper;
import top.x2h.entity.Photo;
import top.x2h.service.PhotoService;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service

public class PhotoServiceImpl implements PhotoService {
    @Autowired
    private PhotoMapper photoMapper;
    @Override
    public List<Photo> displayPhotoByAlbumId(Integer albumId){
        return photoMapper.displayPhotoByAlbumId(albumId);
    }

    @Override
    public void addPhotosToAlbum(int albumId, List<MultipartFile> photos, String basePath) {

        // 获取当前日期路径（与创建时保持一致）
        String dateDir = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

        File dir = new File(basePath, dateDir);
        if (!dir.exists() && !dir.mkdirs()) {
            throw new RuntimeException("创建目录失败：" + dir.getAbsolutePath());
        }

        List<Photo> photoList = new ArrayList<>();

        for (MultipartFile file : photos) {
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File targetFile = new File(dir, fileName);

            try {
                file.transferTo(targetFile);
            } catch (IOException e) {
                throw new RuntimeException("图片保存失败", e);
            }

            String url = "/images/" + dateDir + "/" + fileName;

            Photo photo = new Photo();
            photo.setAlbumId(albumId);
            photo.setUrl(url);
            photo.setDescription(file.getOriginalFilename());

            photoList.add(photo);
        }

        for (Photo photo : photoList) {
            photoMapper.insertPhoto(photo);
        }
    }
    @Override
    public void deletePhoto(Integer id) {
        photoMapper.deletePhoto(id);
    }
    @Override
    public void adminDeletePhoto(Integer id) {
        photoMapper.deletePhoto(id);
    }


}
