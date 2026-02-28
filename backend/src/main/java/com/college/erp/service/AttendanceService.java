package com.college.erp.service;

import com.college.erp.entity.Attendance;
import com.college.erp.repository.AttendanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AttendanceService {
    @Autowired
    private AttendanceRepository attendanceRepository;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    public Attendance markAttendance(Attendance attendance) {
        Attendance saved = attendanceRepository.save(attendance);
        // Real-time update for dashboard
        if (saved.getStudent() != null) {
            messagingTemplate.convertAndSend("/topic/attendance",
                    "Attendance updated for student: " + saved.getStudent().getId());
        }
        return saved;
    }

    public List<Attendance> getStudentAttendance(Long studentId) {
        return attendanceRepository.findByStudentId(studentId);
    }
}
