package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.entity.Photo;
import top.x2h.entity.User;
import top.x2h.method.Sakura;
import top.x2h.service.AlbumService;
import top.x2h.service.PhotoService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/")

public class PhotoController {
    @Autowired
    private PhotoService photoService;
    @Autowired
    private AlbumService albumService;



    // 查看自己相册下的所有图片   --------------已通过测试
    @GetMapping("/albumByPhoto")
    public String albumByPhoto(@RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "5") Integer size,
                               @RequestParam Integer albumId, Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!albumService.isYourAlbum(albumId, user.getId())) {
            model.addAttribute("error", "无权操作！");
            return "redirect:/myalbum";
        }
        List<Photo> photos = photoService.displayPhotoByAlbumId(albumId);
        List<Photo> pagePhoto= Sakura.page(photos, page, size, model, "photos");
       model.addAttribute("albumId",albumId);
      return "albumByPhoto";
    }

    // 查看公开相册下的所有图片   --------------已通过测试
    @GetMapping("/publicAlbumByPhoto")
    public String publicAlbumByPhoto(@RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "6") Integer size,
            @RequestParam Integer albumId, Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Photo> photos = photoService.displayPhotoByAlbumId(albumId);
        List<Photo> pagePhoto= Sakura.page(photos, page,size, model, "photos");
        model.addAttribute("photos", pagePhoto);
        model.addAttribute("albumId",albumId);
        return "photos";
    }


    // 管理员查看所有图片   --------------已通过测试
    @GetMapping("/admin/AlbumByPhoto")
    public String adminAlbumByPhoto(@RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "15") Integer size,
            @RequestParam Integer albumId, Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.getRole().equals("admin")) {
            model.addAttribute("error", "无权操作！");
            return "redirect:error";
        }

        List<Photo> photos = photoService.displayPhotoByAlbumId(albumId);
        List<Photo> pagePhoto= Sakura.page(photos, page,size, model, "photos");
        model.addAttribute("photos", pagePhoto);
        model.addAttribute("albumId",albumId);
        return "/admin/adminAlbumByPhotos";
    }

    //带参数跳转到添加图片页面。 --------------已通过测试
    @GetMapping("/addPhotoToAlbum")
    public String toAddPhoto(@RequestParam Integer albumId, Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("albumId",albumId);
        return "addPhotoToAlbum";
    }


    //向已经存在的相册中添加图片。 --------------已通过测试
    @PostMapping("/addPhotoToAlbum")
    public String addPhoto(@ModelAttribute Photo photo,
                          @RequestParam("photos") List<MultipartFile> photos,@RequestParam Integer albumId,
                          HttpSession session, HttpServletRequest request){
        User user=(User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        photoService.addPhotosToAlbum(albumId, photos, request.getServletContext().getRealPath("/images"));
        return "redirect:/albumByPhoto?albumId="+photo.getAlbumId();
    }


    // 删除图片    --------------已通过测试
    @GetMapping("/deletePhoto")
    public String deletePhoto(@RequestParam Integer id,@RequestParam Integer albumId, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        photoService.deletePhoto(id);
        return "redirect:/albumByPhoto?albumId="+albumId;
    }

    // 管理员删除图片。 --------------已通过测试
    @GetMapping("/admin/deletePhoto")
    public String adminDeletePhoto(@RequestParam Integer id,@RequestParam Integer albumId, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.getRole().equals("admin")) {
            return "redirect:/error";
        }
        photoService.adminDeletePhoto(id);
        return "redirect:/admin/AlbumByPhoto?albumId="+albumId;
    }

}
