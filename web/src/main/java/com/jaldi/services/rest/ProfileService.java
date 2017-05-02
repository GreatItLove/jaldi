package com.jaldi.services.rest;

import com.jaldi.services.common.FileStorageService;
import com.jaldi.services.common.security.CustomAuthenticationToken;
import com.jaldi.services.dao.UserDaoImpl;
import com.jaldi.services.model.DataStore;
import com.jaldi.services.model.User;
import com.jaldi.services.model.request.UpdateProfileRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.xml.bind.DatatypeConverter;
import java.util.UUID;

@RestController
@RequestMapping("/rest/profile")
public class ProfileService {

    @Autowired
    private UserDaoImpl userDao;

    @Autowired
    private FileStorageService fileStorageService;

    @GetMapping("/{id}")
    public User findOne(@PathVariable("id") long id) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        return userDao.getById(currentUser.getId());
    }

    @RequestMapping(value="/{id}", method= RequestMethod.PUT)
    public User updateProfile(@RequestBody User user) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        user.setId(currentUser.getId());
        return userDao.updateProfile(user);
    }

    @PostMapping("/changePassword")
    public ResponseEntity changePassword(@RequestBody UpdateProfileRequest request) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        request.setId(currentUser.getId());
        boolean updated = userDao.updatePassword(request);
        if(!updated) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
        return ResponseEntity.ok(null);
    }

    @PostMapping("/updateProfilePicture")
    public User updateProfilePicture(@RequestBody UpdateProfileRequest request) {
        CustomAuthenticationToken token = (CustomAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        User currentUser = token.getUser();
        request.setId(currentUser.getId());
        User user = new User();
        String fileId = UUID.randomUUID().toString();
        String url = fileStorageService.saveFile(DatatypeConverter.parseBase64Binary(request.getProfileImageBase64()), fileId);
        DataStore ds = new DataStore();
        ds.setId(fileId);
        ds.setType(DataStore.Type.PROFILE_IMAGE);
        ds.setName(fileId);
        ds.setContentType("image/png");
        ds.setUrl(url);
        user.setProfileImageId(userDao.updateProfilePicture(request, ds));
        return user;
    }
}
