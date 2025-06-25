package top.x2h.controller;

import com.mysql.cj.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import top.x2h.entity.Photo;
import top.x2h.entity.User;
import top.x2h.service.AlbumService;
import top.x2h.service.PhotoService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")

public class PhotoController {
    @Autowired
    private PhotoService photoService;
    private AlbumService albumService;



    // 查看相册下的所有图片   --------------已通过测试
    @GetMapping("/albumByPhoto")
    public String albumByPhoto(@RequestParam Integer albumId, Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Photo> photos = photoService.displayPhotoByAlbumId(albumId);
       model.addAttribute("photos",photos);
      return "albumByPhoto";
    }
}
