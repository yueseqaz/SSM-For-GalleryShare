package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.x2h.service.DashboardService;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/dashboard")
    public String dashboardPage(Model model) {
        model.addAttribute("totalUsers", dashboardService.countAllUsers());
        model.addAttribute("activeUsers", dashboardService.countActiveUsers());
        model.addAttribute("adminUsers", dashboardService.countAdminUsers());
        model.addAttribute("totalAlbums", dashboardService.countAllAlbums());
        model.addAttribute("publicAlbums", dashboardService.countPublicAlbums());
        model.addAttribute("totalPhotos", dashboardService.countAllPhotos());
        model.addAttribute("totalLikes", dashboardService.countAllLikes());
        model.addAttribute("mostLikedAlbum", dashboardService.findMostLikedAlbum());
        return "admin/homepage";
    }

    @GetMapping("/dashboardStats")
    @ResponseBody
    public Map<String, Object> dashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", dashboardService.countAllUsers());
        stats.put("activeUsers", dashboardService.countActiveUsers());
        stats.put("adminUsers", dashboardService.countAdminUsers());
        stats.put("totalAlbums", dashboardService.countAllAlbums());
        stats.put("publicAlbums", dashboardService.countPublicAlbums());
        stats.put("totalPhotos", dashboardService.countAllPhotos());
        stats.put("totalLikes", dashboardService.countAllLikes());
        stats.put("mostLikedAlbum", dashboardService.findMostLikedAlbum());
        return stats;
    }
}

