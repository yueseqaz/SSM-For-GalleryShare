package top.x2h.method;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import top.x2h.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Sakura {
    public static User checkAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "你没有权限访问这个接口！");
        }
        return user;
    }
            public static <T> List<T> page(List<T> fullList, int page, int size, Model model, String listAttributeName) {
            int total = fullList.size();
            int totalPages = (int) Math.ceil((double) total / size);
            page = Math.max(1, Math.min(page, totalPages));

            int fromIndex = (page - 1) * size;
            int toIndex = Math.min(fromIndex + size, total);
            List<T> pagedList = fullList.subList(fromIndex, toIndex);

            model.addAttribute(listAttributeName, pagedList);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);

            return pagedList;
        }
    public static String save(MultipartFile file, HttpServletRequest request) {
        String dateDir = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String uploadDir = request.getServletContext().getRealPath("/images/" + dateDir);
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            if (!dir.mkdirs()) {
                throw new RuntimeException("创建目录失败：" + uploadDir);
            }
        }
        String originalFilename = file.getOriginalFilename();
        String fileName = System.currentTimeMillis() + "_" + originalFilename;
        File targetFile = new File(dir, fileName);
        try {
            file.transferTo(targetFile);
        } catch (IOException e) {
            throw new RuntimeException("图片保存失败", e);
        }
        return "/images/" + dateDir + "/" + fileName;
    }
    }
