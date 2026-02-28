package com.college.erp.service;

import com.college.erp.entity.Complaint;
import com.college.erp.entity.ComplaintStatus;
import com.college.erp.entity.User;
import com.college.erp.repository.ComplaintRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ComplaintService {
    @Autowired
    private ComplaintRepository complaintRepository;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    public Complaint submitComplaint(@NonNull Complaint complaint) {
        Complaint saved = complaintRepository.save(complaint);
        // Notify Principal in real-time
        messagingTemplate.convertAndSend("/topic/admin/complaints", "New complaint submitted: " + saved.getTitle());
        return saved;
    }

    public Complaint updateStatus(@NonNull Long id, @NonNull ComplaintStatus status) {
        Complaint complaint = complaintRepository.findById(id).orElseThrow();
        complaint.setStatus(status);
        Complaint saved = complaintRepository.save(complaint);

        // Notify user about status update
        if (saved.getUser() != null) {
            messagingTemplate.convertAndSendToUser(
                    saved.getUser().getUsername(),
                    "/queue/notifications",
                    "Your complaint '" + saved.getTitle() + "' is now " + status);
        }

        return saved;
    }

    public List<Complaint> getAllComplaints() {
        return complaintRepository.findAll();
    }
}
