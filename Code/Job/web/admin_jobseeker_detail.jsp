<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết Jobseeker</title>
        <style>
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }
            .profile-section {
                margin: 20px 0;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .profile-section h3 {
                color: #333;
                margin-bottom: 15px;
            }
            .profile-section p {
                margin: 5px 0;
            }
            .profile-section strong {
                color: #4CAF50;
            }
            .skills-section {
                margin-top: 20px;
            }
            .skill-item {
                margin: 5px 0;
                padding: 5px;
                background-color: #f9f9f9;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Chi tiết Jobseeker</h1>
            
            <div class="profile-section">
                <h3>Thông tin cá nhân</h3>
                <p><strong>ID:</strong> ${jobseeker.freelanceID}</p>
                <p><strong>Username:</strong> ${jobseeker.username}</p>
                <p><strong>Họ tên:</strong> ${jobseeker.firstName} ${jobseeker.lastName}</p>
                <p><strong>Giới tính:</strong> ${jobseeker.gender ? 'Nam' : 'Nữ'}</p>
                <p><strong>Ngày sinh:</strong> ${jobseeker.dob}</p>
                <p><strong>Email:</strong> ${jobseeker.emailContact}</p>
                <p><strong>Số điện thoại:</strong> ${jobseeker.phoneContact}</p>
                <p><strong>Trạng thái:</strong> ${jobseeker.status}</p>
            </div>
            
            <div class="profile-section">
                <h3>Học vấn</h3>
                <c:forEach items="${jobseeker.educations}" var="edu">
                    <p><strong>${edu.universityName}</strong> (${edu.startDate} - ${edu.endDate})</p>
                </c:forEach>
            </div>
            
            <div class="profile-section">
                <h3>Kinh nghiệm làm việc</h3>
                <c:forEach items="${jobseeker.experiences}" var="exp">
                    <p><strong>${exp.experienceWorkName}</strong> - ${exp.position} (${exp.startDate} - ${exp.endDate})</p>
                    <p><em>${exp.yourProject}</em></p>
                </c:forEach>
            </div>
            
            <div class="profile-section skills-section">
                <h3>Kỹ năng</h3>
                <c:forEach items="${jobseeker.skills}" var="skill">
                    <div class="skill-item">
                        <strong>${skill.skillSetName}</strong> - Mức độ: ${skill.level}/5
                    </div>
                </c:forEach>
            </div>
            
            <div style="margin-top: 20px;">
                <a href="jobseeker?action=list" class="btn-back">Quay lại danh sách</a>
            </div>
        </div>
    </body>
</html>
