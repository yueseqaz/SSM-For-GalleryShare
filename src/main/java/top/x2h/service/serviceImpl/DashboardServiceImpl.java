package top.x2h.service.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.x2h.Mapper.DashboardMapper;
import top.x2h.service.DashboardService;

import java.util.Map;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    private DashboardMapper dashboardMapper;
@Override
    public int countAllUsers() {
        return dashboardMapper.countAllUsers();
    }
@Override
    public int countActiveUsers() {
        return dashboardMapper.countActiveUsers();
    }
    @Override
    public int countAdminUsers() {
        return dashboardMapper.countAdminUsers();
    }
    @Override
    public int countAllAlbums() {
        return dashboardMapper.countAllAlbums();
    }
    @Override
    public int countPublicAlbums() {
        return dashboardMapper.countPublicAlbums();
    }
    @Override
    public int countAllPhotos() {
        return dashboardMapper.countAllPhotos();
    }
    @Override
    public int countAllLikes() {
        return dashboardMapper.countAllLikes();
    }

    @Override
    public Map<String, Object> findMostLikedAlbum() {
        return dashboardMapper.findMostLikedAlbum();
    }
}
