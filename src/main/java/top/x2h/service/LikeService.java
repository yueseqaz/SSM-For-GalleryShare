package top.x2h.service;

import org.springframework.stereotype.Service;
import top.x2h.entity.Album;
import top.x2h.entity.Like;

import java.util.List;

@Service

public interface LikeService {
    void like(Integer albumId,Integer userId);
    Integer count(Integer albumId);
    Integer isLiked(Integer albumId,Integer userId);

}
