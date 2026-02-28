package com.college.erp.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileStorageService {

    private final String UPLOAD_DIR = "uploads/photos/";
    private final long MAX_FILE_SIZE = 2 * 1024 * 1024; // 2MB
    private final String[] ALLOWED_EXTENSIONS = { "jpg", "jpeg", "png" };

    public FileStorageService() {
        // Create upload directories if they don't exist
        try {
            Files.createDirectories(Paths.get(UPLOAD_DIR + "students"));
            Files.createDirectories(Paths.get(UPLOAD_DIR + "staff"));
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directories", e);
        }
    }

    /**
     * Save a photo file and return the relative path
     * 
     * @param file The multipart file to save
     * @param type Either "students" or "staff"
     * @return The relative path to the saved file
     */
    public String savePhoto(MultipartFile file, String type) throws IOException {
        // Validate file
        validatePhoto(file);

        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = getFileExtension(originalFilename);
        String filename = UUID.randomUUID().toString() + "." + extension;

        // Determine storage path
        Path uploadPath = Paths.get(UPLOAD_DIR + type);
        Path filePath = uploadPath.resolve(filename);

        // Save file
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Return relative path
        return type + "/" + filename;
    }

    /**
     * Delete a photo file
     * 
     * @param relativePath The relative path returned by savePhoto
     */
    public void deletePhoto(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) {
            return;
        }

        try {
            Path filePath = Paths.get(UPLOAD_DIR + relativePath);
            Files.deleteIfExists(filePath);
        } catch (IOException e) {
            // Log error but don't throw exception
            System.err.println("Failed to delete photo: " + relativePath);
        }
    }

    /**
     * Validate photo file
     * 
     * @param file The file to validate
     * @throws IllegalArgumentException if validation fails
     */
    public void validatePhoto(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }

        // Check file size
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException("File size exceeds 2MB limit");
        }

        // Check file extension
        String filename = file.getOriginalFilename();
        String extension = getFileExtension(filename);

        boolean validExtension = false;
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (allowed.equalsIgnoreCase(extension)) {
                validExtension = true;
                break;
            }
        }

        if (!validExtension) {
            throw new IllegalArgumentException("Only JPG and PNG files are allowed");
        }
    }

    /**
     * Get file extension from filename
     */
    private String getFileExtension(String filename) {
        if (filename == null || filename.isEmpty()) {
            return "";
        }
        int lastDot = filename.lastIndexOf('.');
        if (lastDot == -1) {
            return "";
        }
        return filename.substring(lastDot + 1);
    }

    /**
     * Get the full path to a photo
     * 
     * @param relativePath The relative path
     * @return The full filesystem path
     */
    public Path getPhotoPath(String relativePath) {
        return Paths.get(UPLOAD_DIR + relativePath);
    }
}
