package com.college.erp.service;

import com.college.erp.entity.TimetableApproval;
import com.college.erp.entity.circular.Circular;
import com.college.erp.entity.circular.enums.CircularStatus;
import com.college.erp.repository.CircularRepository;
import com.college.erp.repository.TimetableApprovalRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PrincipalApprovalService {

    private final TimetableApprovalRepository timetableApprovalRepository;
    private final CircularRepository circularRepository;

    public Map<String, Object> getPendingApprovals() {
        Map<String, Object> pending = new HashMap<>();

        // 1. Timetables
        List<Map<String, Object>> timetables = timetableApprovalRepository
                .findByStatus(TimetableApproval.ApprovalStatus.SUBMITTED)
                .stream().map(t -> {
                    Map<String, Object> m = new HashMap<>();
                    m.put("id", t.getId());
                    m.put("department", t.getDepartment().getName());
                    m.put("academicYear", t.getAcademicYear());
                    m.put("semester", t.getSemester());
                    m.put("submittedAt", t.getSubmittedAt());
                    return m;
                }).toList();
        pending.put("timetables", timetables);

        // 2. Circulars (For Principal, maybe global or HOD circulars requiring
        // override, but circulars auto-approve for HOD in their own dept.
        // If a Faculty circular requires HOD approval, Principal CAN override, but
        // usually HOD does it.
        // Let's just fetch all PENDING_APPROVAL circulars for global insight or those
        // routed to Principal).
        List<Circular> circulars = circularRepository.findByStatusOrderByCreatedAtDesc(CircularStatus.PENDING_APPROVAL);
        pending.put("circulars", circulars);

        return pending;
    }

    @Transactional
    public void approveTimetable(Long id, boolean approve, String remarks) {
        TimetableApproval approval = timetableApprovalRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Timetable Approval Request not found"));

        approval.setStatus(
                approve ? TimetableApproval.ApprovalStatus.APPROVED : TimetableApproval.ApprovalStatus.REJECTED);
        approval.setRemarks(remarks);
        approval.setReviewedAt(LocalDateTime.now());
        timetableApprovalRepository.save(approval);
    }

    @Transactional
    public void approveCircular(Long id, boolean approve, String remarks) {
        Circular circular = circularRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Circular not found"));
        circular.setStatus(approve ? CircularStatus.APPROVED : CircularStatus.REJECTED);
        circularRepository.save(circular);
    }
}
