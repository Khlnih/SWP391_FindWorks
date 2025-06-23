<%@page import="java.util.ArrayList"%>
<%@page import="Model.AccountTier"%>
<%@page import="DAO.AccountTierDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gói Tài Khoản - FindWorks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .pricing-card {
            border: none;
            border-radius: 10px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }
        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }
        .pricing-header {
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: white;
            padding: 30px 0;
            border-radius: 10px 10px 0 0;
            position: relative;
        }
        .pricing-body {
            padding: 30px;
            background: white;
            border-radius: 0 0 10px 10px;
        }
        .price {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 15px 0;
        }
        .price-period {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.8);
        }
        .btn-subscribe {
            background: #4e54c8;
            color: white;
            padding: 10px 30px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            width: 80%;
            margin: 10px auto;
            display: block;
        }
        .btn-subscribe:hover {
            background: #3a3f9e;
            color: white;
            transform: translateY(-2px);
        }
        .feature-list {
            list-style: none;
            padding: 0;
            margin: 20px 0;
            text-align: left;
        }
        .feature-list li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }
        .feature-list li i {
            margin-right: 10px;
            color: #4e54c8;
        }
        .popular-tag {
            position: absolute;
            top: 15px;
            right: -30px;
            background: #ffc107;
            color: #000;
            padding: 5px 30px;
            transform: rotate(45deg);
            font-size: 0.8rem;
            font-weight: 600;
            width: 150px;
            text-align: center;
        }
        .section-title {
            position: relative;
            margin-bottom: 50px;
            text-align: center;
        }
        .section-title:after {
            content: '';
            display: block;
            width: 80px;
            height: 3px;
            background: #4e54c8;
            margin: 15px auto 0;
        }
    </style>
</head>
<body>
    
<jsp:include page="/includes/jobseeker_sidebar.jsp" />
<div class="container-fluid bg-primary py-5 mb-5">
        <div class="container py-5">
            <div class="row align-items-center">
                <div class="col-lg-12 text-center">
                    <h1 class="display-5 text-white mb-3">NÂNG CẤP TÀI KHOẢN</h1>
                    <p class="lead text-white mb-0">Mở khóa nhiều tính năng hơn với gói tài khoản cao cấp</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Pricing Section -->
    <div class="container py-5">
        <h2 class="section-title">Chọn Gói Dịch Vụ</h2>
        <div class="row justify-content-center">
            <jsp:useBean id="accountTierDAO" class="DAO.AccountTierDAO" scope="page" />
            <% 
                ArrayList<AccountTier> tiers = accountTierDAO.getAllAccountTierForJobseeker();
                if (tiers != null && !tiers.isEmpty()) {
                    for (AccountTier tier : tiers) {
                        boolean isPopular = tier.getTierName().equalsIgnoreCase("Professional");
            %>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="pricing-card h-100">
                    <% if (isPopular) { %>
                    <div class="popular-tag">PHỔ BIẾN</div>
                    <% } %>
                    <div class="pricing-header text-center">
                        <h3 class="mb-0"><%= tier.getTierName() %></h3>
                        <div class="price">
                            <%= tier.getPrice().intValue() %>.000<small class="price-period">/VNĐ</small>
                        </div>
                        <p class="mb-0">Thời hạn: <%= tier.getDurationDays() %> ngày</p>
                    </div>
                    <div class="pricing-body text-center">
                        <p class="text-muted"><%= tier.getDescription() %></p>
                        <ul class="feature-list">
                            <li><i class="fas fa-check"></i> Giới hạn đăng tin: <%= tier.getJobPostLimit() %></li>
                            <li><i class="fas fa-check"></i> Ưu tiên hiển thị</li>
                            <li><i class="fas fa-check"></i> Tăng khả năng hiển thị hồ sơ</li>
                            <li><i class="fas fa-check"></i> Hỗ trợ 24/7</li>
                        </ul>
                            <form action="ffavoriteController" method="GET">
                                <input type="hidden" name="action" value="register">
                                <input type="hidden" name="jobseekerID" value="${sessionScope.jobseeker.getFreelancerID()}">
                                <input type="hidden" name="tierID" value="<%= tier.getTierID() %>">
                                <input type="hidden" name="duration" value="<%= tier.getDurationDays() %>">
                                <button type="submit" class="btn btn-subscribe">Đăng ký ngay</button>
                            </form>
                        
                    </div>
                </div>
            </div>
            <% 
                    }
                } else { 
            %>
            <div class="col-12 text-center">
                <div class="alert alert-info">
                    Hiện chưa có gói dịch vụ nào. Vui lòng quay lại sau.
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Features Section -->
    <div class="container-fluid bg-light py-5">
        <div class="container">
            <h2 class="section-title">Lợi Ích Khi Nâng Cấp</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-white rounded shadow-sm h-100">
                        <div class="icon-box mb-4">
                            <i class="fas fa-bolt fa-3x text-primary"></i>
                        </div>
                        <h4>Ưu Tiên Ứng Tuyển</h4>
                        <p>Đơn ứng tuyển của bạn sẽ được ưu tiên hiển thị với nhà tuyển dụng, tăng cơ hội được chọn.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-white rounded shadow-sm h-100">
                        <div class="icon-box mb-4">
                            <i class="fas fa-eye fa-3x text-primary"></i>
                        </div>
                        <h4>Hiển Thị Hồ Sơ</h4>
                        <p>Tăng khả năng hiển thị hồ sơ với các nhà tuyển dụng hàng đầu.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-white rounded shadow-sm h-100">
                        <div class="icon-box mb-4">
                            <i class="fas fa-headset fa-3x text-primary"></i>
                        </div>
                        <h4>Hỗ Trợ Chuyên Nghiệp</h4>
                        <p>Đội ngũ hỗ trợ chuyên nghiệp sẵn sàng giải đáp mọi thắc mắc của bạn.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FAQ Section -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <h2 class="section-title">Câu Hỏi Thường Gặp</h2>
                <div class="accordion" id="faqAccordion">
                    <div class="accordion-item mb-3 border rounded">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Gói dịch vụ hoạt động như thế nào?
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Khi đăng ký gói dịch vụ, bạn sẽ được tính phí ngay lập tức. Gói dịch vụ sẽ có hiệu lực trong thời gian đã chọn (ví dụ: 30 ngày). Sau thời gian này, gói dịch vụ sẽ tự động gia hạn nếu bạn không hủy.
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item mb-3 border rounded">
                        <h2 class="accordion-header" id="headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                Tôi có thể thay đổi hoặc hủy gói không?
                            </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Có, bạn có thể nâng cấp, hạ cấp hoặc hủy gói dịch vụ bất cứ lúc nào. Nếu hủy, bạn vẫn có thể sử dụng các tính năng cho đến khi kết thúc kỳ hạn hiện tại.
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item mb-3 border rounded">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                Các phương thức thanh toán được chấp nhận?
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                Chúng tôi chấp nhận thanh toán qua thẻ ngân hàng nội địa, thẻ quốc tế (Visa, MasterCard) và ví điện tử (Momo, ZaloPay).
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
