package top.x2h.Mapper;

import java.util.Map;
public interface DashboardMapper {

    int countAllUsers();

    int countActiveUsers();

    int countAdminUsers();

    int countAllAlbums();

    int countPublicAlbums();

    int countAllPhotos();

    int countAllLikes();

    Map<String, Object> findMostLikedAlbum(); // key: id, title, like_count
}
