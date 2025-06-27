package top.x2h.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.x2h.Mapper.TagsMapper;
import top.x2h.entity.Album;
import top.x2h.entity.Tags;
import top.x2h.entity.User;
import top.x2h.method.Sakura;
import top.x2h.service.AlbumService;
import top.x2h.service.LikeService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("/")
public class AlbumController {
    @Autowired
    private AlbumService albumService;
    @Autowired
    private LikeService likeService;
    @Autowired
    private TagsMapper tagsMapper;

    // 获取所有相册 包括查看其他用户的相册  ----------已通过测试
    @GetMapping("/getAllAlbum")
    public String getAllAlbum(@RequestParam(defaultValue = "1") Integer page,
                              @RequestParam(defaultValue = "10") Integer size,
                              Model model) {
        List<Album> albumList = albumService.displayAllAlbum();

        List<Album> pageAlbum = Sakura.page(albumList, page, size, model, "album");

        Map<Integer, Integer> likeCountMap = new HashMap<>();
        for (Album album : pageAlbum) {
            int likeCount = likeService.count(album.getId());
            likeCountMap.put(album.getId(), likeCount);

            List<Tags> tags = tagsMapper.selectTagsByAlbumId(album.getId());
            album.setTags(tags);
        }

        model.addAttribute("album", pageAlbum);
        model.addAttribute("likeCountMap", likeCountMap);
        return "gallery";
    }





    //创建相册   --------------------已通过测试
    @PostMapping("/album/create")
    public String createAlbum(@ModelAttribute Album album,
                              @RequestParam("photos") List<MultipartFile> photos,
                              @RequestParam("tagsName") List<String> tagsName,
                              HttpSession session, HttpServletRequest  request) {
        User user=(User) session.getAttribute("user");
        String basePath = request.getServletContext().getRealPath("/images");
        if (user == null) {
            return "redirect:/login";
        }
        album.setUserId(user.getId());

        albumService.createAlbumWithPhotos(album, photos, basePath,tagsName);

        return "redirect:/getAllAlbum";
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



    // 用户自己修改相册状态   ------------已通过测试
    @GetMapping("changeAlbumStatus")
    public String changeAlbumStatus(@RequestParam Integer albumId,@RequestParam String status, HttpSession session,Model  model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!albumService.isYourAlbum(albumId, user.getId())) {
            model.addAttribute("error", "无权操作！");
            return "redirect:/myalbum";
        }
        if (!status.equals("public") && !status.equals("private")) {
            model.addAttribute("error", "状态错误！");
            return "redirect:/myalbum";
        }
        if (status.equals("public")) {
            status="public";
        }
        if (status.equals("private")) {
            status="private";
        }
        albumService.changeAlbumStatus(albumId,status);
        return "redirect:/myalbum";
    }



    // 管理员修改相册状态 ----------------已通过测试
    @GetMapping("/admin/changeAlbumStatus")
    public String adminChangeAlbumStatus(@RequestParam Integer albumId,@RequestParam String status, HttpSession session,Model  model) {
        User user = (User) session.getAttribute("user");
        if (!user.getRole().equals("admin")){
            return "redirect:/login";
        }
        if (!status.equals("public") && !status.equals("private")) {
            model.addAttribute("error", "状态错误！");
            return "redirect:/admin/getAllAlbum";
        }
        albumService.changeAlbumStatus(albumId,status);
        return "redirect:/admin/getAllAlbum";
    }




    //管理员删除相册    ------------------已通过测试
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


    //管理员获取所有相册   ------------------已通过测试
    @GetMapping("/admin/getAllAlbum")
    public String adminGetAllAlbum(@RequestParam(defaultValue = "1") Integer page,
                                   @RequestParam(defaultValue = "10") Integer size,
                                   Model model) {
        List<Album> albumList = albumService.adminDisplayAllAlbum();
        List<Album> pageAlbum = Sakura.page(albumList, page, size, model, "album");
        for (Album album : pageAlbum) {
            List<Tags> tags = tagsMapper.selectTagsByAlbumId(album.getId());
            album.setTags(tags);
        }

        model.addAttribute("album", pageAlbum);
        return "admin/albummanage";
    }


    // 根据标签搜索相册   ------------------已通过测试
    @GetMapping("/album/searchByTag")
    public String searchByTag(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<Album> albumList = albumService.searchAlbumByTagKeywordAndUserId(keyword, user.getId());

        for (Album album : albumList) {
            List<Tags> tags = tagsMapper.selectTagsByAlbumId(album.getId());
            album.setTags(tags);
        }

        model.addAttribute("albums", albumList);
        return "search";
    }


    @PostMapping("/editAlbum")
    public String editAlbum(@ModelAttribute Album album, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        albumService.editAlbum(album);
        return "redirect:/admin/getAllAlbum";
    }


    //修改相册获取 以及把ID 传给编辑页面 标题 描述  ------------已完成
    @GetMapping("/editAlbum")
    public String toEditAlbum(@RequestParam Integer albumId, Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        if (!albumService.isYourAlbum(albumId, user.getId())){
            model.addAttribute("error", "无权操作！");
        }
        Album album = albumService.selectAlbumById(albumId);
        model.addAttribute("album", album);
        return "editAlbum"; // 返回视图名 editAlbum.jsp
    }

    @GetMapping("/admin/editAlbum")
    public String adminToEditAlbum(@RequestParam Integer albumId, Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("admin"))
        {return "redirect:/login";}
        Album album = albumService.selectAlbumById(albumId);
        model.addAttribute("album", album);
        return "editAlbum";
    }





}
