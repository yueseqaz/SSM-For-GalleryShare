package top.x2h.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.x2h.Mapper.AlbumMapper;
import top.x2h.Mapper.LikeMapper;
import top.x2h.entity.Album;
import top.x2h.service.LikeService;

import java.util.List;

@Service

public class LikeServiceImpl implements LikeService {
    @Autowired
    private LikeMapper likeMapper;
    @Autowired
    private AlbumMapper albumMapper;
    @Override
    public void like(Integer albumId, Integer userId) {
        likeMapper.like(albumId,userId);
    }
    @Override
    public Integer count(Integer albumId) {
        return likeMapper.count(albumId);
    }
    @Override
    public Integer isLiked(Integer albumId, Integer userId) {
        return likeMapper.isLiked(albumId,userId);
    }


    @Override
    public void cancelLike(Integer albumId, Integer userId) {
        likeMapper.cancelLike(albumId,userId);
    }

}
