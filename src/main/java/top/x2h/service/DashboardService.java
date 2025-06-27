package top.x2h.service;

import org.springframework.stereotype.Service;

import java.util.Map;
@Service
public interface DashboardService {
    int countAllUsers();
    int countActiveUsers();
    int countAdminUsers();
    int countAllAlbums();
    int countPublicAlbums();
    int countAllPhotos();
    int countAllLikes();
    Map<String, Object> findMostLikedAlbum();
}
