package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import top.x2h.entity.Album;
import top.x2h.entity.User;
import top.x2h.service.AlbumService;
import top.x2h.service.LikeService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/")
public class LikeController {
    @Autowired
    private LikeService likeService;
    @Autowired
    private AlbumService albumService;
    @GetMapping("/like")
    public String like(@RequestParam Integer albumId, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        Integer likedCount = likeService.isLiked(albumId, user.getId());

        if (likedCount == null || likedCount == 0) {
            likeService.like(albumId, user.getId());
            redirectAttributes.addFlashAttribute("success", "点赞成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "你已经点过赞了！");
        }

        return "redirect:/getAllAlbum";
    }

    @GetMapping("/myLike")
    public String myLike( HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        List<Album> likedAlbums = albumService.getLikedAlbumsByUserId(user.getId());
        model.addAttribute("likedAlbums", likedAlbums);
        return "myLike";
    }

    }
