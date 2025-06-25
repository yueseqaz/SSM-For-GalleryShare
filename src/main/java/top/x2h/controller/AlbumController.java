package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.entity.Album;
import top.x2h.entity.User;
import top.x2h.method.Sakura;
import top.x2h.service.AlbumService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller

@RequestMapping("/")
public class AlbumController {
    @Autowired
    private AlbumService albumService;

    // 获取所有相册 包括查看其他用户的相册  ----------已通过测试
    @GetMapping("/getAllAlbum")
    public String getAllAlbum(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size, Model model){
        List<Album> album=albumService.displayAllAlbum();
        List<Album> pagealbum=Sakura.page(album,page,size,model,"album");
        model.addAttribute("album",album);
        System.out.println("相册列表：" + album);
        return "gallery";
    }

    //创建相册   ----------已通过测试
    @PostMapping("/album/create")
    public String createAlbum(@ModelAttribute Album album,
                              @RequestParam("photos") List<MultipartFile> photos,
                              HttpSession session, HttpServletRequest  request) {
        User user=(User) session.getAttribute("user");
        String basePath = request.getServletContext().getRealPath("/images");
        if (user == null) {
            return "redirect:/login";
        }
        album.setUserId(user.getId());

        albumService.createAlbumWithPhotos(album, photos, basePath);

        return "redirect:/album/list";
    }


    // 获取用户当前所有相册 ----------已通过测试
    @GetMapping("/myalbum")
    public String myAlbum(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Album> albums = albumService.displayMyAllAlbum(user.getId());
        model.addAttribute("albums", albums);
        return "myalbum";
    }

    // 用户自己删除自己相册      ----------已通过测试
    @GetMapping("/deleteAlbum")
    public String deleteAlbum(@RequestParam Integer id, HttpSession session,Model  model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!albumService.isYourAlbum(id, user.getId())) {
            model.addAttribute("error", "无权操作！");
            return "redirect:/myalbum";
        }
        albumService.deleteAlbum(id);
        return "redirect:/myalbum";
    }





    //管理员删除相册
    @GetMapping("/admin/deleteAlbum")
    public String adminDeleteAlbum(@RequestParam Integer id, HttpSession session,Model  model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.getRole().equals("admin")) {
            model.addAttribute("error", "无权操作！");
            return "redirect:/admin/getAllAlbum";
        }
        albumService.deleteAlbum(id);
        return "redirect:/admin/getAllAlbum";
    }
    @GetMapping("/admin/getAllAlbum")
    public String adminGetAllAlbum(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size, Model model){
        List<Album> album=albumService.displayAllAlbum();
        List<Album> pagealbum=Sakura.page(album,page,size,model,"album");
        model.addAttribute("album",album);
        return "admin/getAllAlbum";
    }

}
