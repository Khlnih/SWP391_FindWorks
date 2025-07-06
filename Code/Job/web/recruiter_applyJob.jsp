<!DOCTYPE html>
<!-- This is a static example version without JSTL -->
<html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate List - FindWorks (Static Example)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .candidate-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            transition: all 0.3s ease;
            margin-bottom: 1rem;
        }
        .candidate-card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.35em 0.65em;
        }
        .candidate-avatar {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 50%;
        }
        .sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .main-content {
            padding: 20px;
        }
        .nav-link {
            color: #333;
            border-radius: 5px;
            margin: 2px 0;
        }
        .nav-link:hover, .nav-link.active {
            background-color: #0d6efd;
            color: white;
        }
        .nav-link i {
            width: 20px;
            text-align: center;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/recruiter_slidebar.jsp" />
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 main-content">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Candidate List</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">Export to Excel</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">Print List</button>
                        </div>
                    </div>
                </div>

                <!-- Job Info -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title">Java Spring Boot Developer</h5>
                        <p class="card-text">
                            <i class="fas fa-map-marker-alt text-muted me-2"></i>TP.HCM
                            <span class="mx-2">?</span>
                            <i class="fas fa-clock text-muted me-2"></i>Full-time
                            <span class="mx-2">?</span>
                            <i class="fas fa-calendar-alt text-muted me-2"></i>30/08/2023
                        </p>
                    </div>
                </div>

                <!-- Filters -->
                <div class="card mb-4">
                    <div class="card-body">
                        <form class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Status</label>
                                <select class="form-select">
                                    <option value="">All</option>
                                    <option>Pending</option>
                                    <option>Approved</option>
                                    <option>Rejected</option>
                                    <option>Profile Viewed</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Experience</label>
                                <select class="form-select">
                                    <option value="">All</option>
                                    <option>No experience</option>
                                    <option>Less than 1 year</option>
                                    <option>1-3 years</option>
                                    <option>More than 3 years</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Search</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Candidate name, skills...">
                                    <button class="btn btn-outline-secondary" type="button">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">Filter</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Candidates List -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Candidates (2)</h5>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-sort me-1"></i> Sort by
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Newest</a></li>
                                <li><a class="dropdown-item" href="#">Oldest</a></li>
                                <li><a class="dropdown-item" href="#">Name A-Z</a></li>
                                <li><a class="dropdown-item" href="#">Name Z-A</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                                        

                                        <!-- Interview Schedule Modal -->
                                        <div class="modal fade" id="scheduleModal${candidate.id}" tabindex="-1">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Schedule Interview</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form>
                                                            <div class="mb-3">
                                                                <label class="form-label">Interview Date</label>
                                                                <input type="date" class="form-control" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label">Start Time</label>
                                                                <input type="time" class="form-control" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label">Interview Type</label>
                                                                <select class="form-select" required>
                                                                    <option value="">Select Type</option>
                                                                    <option>On-site</option>
                                                                    <option>Online (Google Meet)</option>
                                                                    <option>Online (Zoom)</option>
                                                                    <option>Phone</option>
                                                                </select>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label">Location/Meeting Room</label>
                                                                <textarea class="form-control" rows="3" 
                                                                          placeholder="Please provide address or meeting link..."></textarea>
                                                            </div>
                                                            <div class="form-check mb-3">
                                                                <input class="form-check-input" type="checkbox" id="sendEmail${candidate.id}">
                                                                <label class="form-check-label" for="sendEmail${candidate.id}">
                                                                    Send email notification to candidate
                                                                </label>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="button" class="btn btn-primary">Save Schedule</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    <!-- Candidate 1 -->
                                    <div class="list-group-item p-0 mb-3 candidate-card">
                                        <div class="row g-0 p-3">
                                            <div class="col-md-2 text-center">
                                                <img src="assets/images/default-avatar.png" 
                                                     alt="Avatar" class="candidate-avatar mb-2">
                                                <div>
                                                    <span class="badge bg-warning status-badge">
                                                        Pending
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <h5 class="card-title mb-1">
                                                    <a href="#" class="text-decoration-none">
                                                        Nguyen Van A
                                                    </a>
                                                </h5>
                                                <p class="text-muted mb-1">
                                                    <i class="fas fa-briefcase me-1"></i> Java Developer 
                                                    <span class="mx-1">?</span>
                                                    <i class="fas fa-graduation-cap me-1"></i> University of Technology
                                                </p>
                                                <p class="text-muted mb-2">
                                                    <i class="fas fa-envelope me-1"></i> nguyenvana@example.com
                                                    <span class="mx-1">?</span>
                                                    <i class="fas fa-phone me-1"></i> 0987654321
                                                </p>
                                                <div class="mb-2">
                                                    <span class="badge bg-light text-dark me-1">Java</span>
                                                    <span class="badge bg-light text-dark me-1">Spring Boot</span>
                                                    <span class="badge bg-light text-dark">MySQL</span>
                                                </div>
                                                <p class="small text-muted mb-0">
                                                    <i class="far fa-clock me-1"></i> Applied on 25/07/2023
                                                </p>
                                            </div>
                                            <div class="col-md-4 d-flex flex-column justify-content-center align-items-end">
                                                <div class="action-buttons">
                                                    <a href="#" class="btn btn-outline-primary btn-sm mb-2">
                                                        <i class="far fa-file-pdf me-1"></i> View CV
                                                    </a>
                                                    <button type="button" class="btn btn-outline-success btn-sm mb-2" 
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#scheduleModal1">
                                                        <i class="fas fa-calendar-check me-1"></i> Schedule
                                                    </button>
                                                    <div class="dropdown d-inline-block">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" 
                                                                type="button" data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu dropdown-menu-end">
                                                            <li>
                                                                <a class="dropdown-item" href="#">
                                                                    <i class="fas fa-check-circle text-success me-2"></i>Approve Application
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item text-danger" href="#">
                                                                    <i class="fas fa-times-circle me-2"></i>Reject
                                                                </a>
                                                            </li>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li>
                                                                <a class="dropdown-item" href="#">
                                                                    <i class="fas fa-comment me-2"></i>Message
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Candidate 2 -->
                                    <div class="list-group-item p-0 mb-3 candidate-card">
                                        <div class="row g-0 p-3">
                                            <div class="col-md-2 text-center">
                                                <img src="assets/images/default-avatar.png" 
                                                     alt="Avatar" class="candidate-avatar mb-2">
                                                <div>
                                                    <span class="badge bg-success status-badge">
                                                        Approved
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <h5 class="card-title mb-1">
                                                    <a href="#" class="text-decoration-none">
                                                        Tran Thi B
                                                    </a>
                                                </h5>
                                                <p class="text-muted mb-1">
                                                    <i class="fas fa-briefcase me-1"></i> Backend Developer
                                                    <span class="mx-1">?</span>
                                                    <i class="fas fa-graduation-cap me-1"></i> University of Science
                                                </p>
                                                <p class="text-muted mb-2">
                                                    <i class="fas fa-envelope me-1"></i> tranb@example.com
                                                    <span class="mx-1">?</span>
                                                    <i class="fas fa-phone me-1"></i> 0912345678
                                                </p>
                                                <div class="mb-2">
                                                    <span class="badge bg-light text-dark me-1">Java</span>
                                                    <span class="badge bg-light text-dark me-1">Spring Boot</span>
                                                    <span class="badge bg-light text-dark">REST API</span>
                                                </div>
                                                <p class="small text-muted mb-0">
                                                    <i class="far fa-clock me-1"></i> Applied on 20/07/2023
                                                </p>
                                            </div>
                                            <div class="col-md-4 d-flex flex-column justify-content-center align-items-end">
                                                <div class="action-buttons">
                                                    <a href="#" class="btn btn-outline-primary btn-sm mb-2">
                                                        <i class="far fa-file-pdf me-1"></i> View CV
                                                    </a>
                                                    <button type="button" class="btn btn-outline-success btn-sm mb-2" 
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#scheduleModal2">
                                                        <i class="fas fa-calendar-check me-1"></i> Schedule
                                                    </button>
                                                    <div class="dropdown d-inline-block">
                                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" 
                                                                type="button" data-bs-toggle="dropdown">
                                                            Actions
                                                        </button>
                                                        <ul class="dropdown-menu dropdown-menu-end">
                                                            <li>
                                                                <a class="dropdown-item" href="#">
                                                                    <i class="fas fa-check-circle text-success me-2"></i>Approved
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a class="dropdown-item text-danger" href="#">
                                                                    <i class="fas fa-times-circle me-2"></i>Cancel Approval
                                                                </a>
                                                            </li>
                                                            <li><hr class="dropdown-divider"></li>
                                                            <li>
                                                                <a class="dropdown-item" href="#">
                                                                    <i class="fas fa-comment me-2"></i>Message
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Pagination -->
                                <nav aria-label="Page navigation" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item disabled">
                                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#">Next</a>
                                        </li>
                                    </ul>
                                </nav>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Interview Schedule Modal 1 -->
    <div class="modal fade" id="scheduleModal1" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Schedule Interview</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Interview Date</label>
                            <input type="date" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Start Time</label>
                            <input type="time" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Interview Type</label>
                            <select class="form-select" required>
                                <option value="">Select Type</option>
                                <option>On-site</option>
                                <option>Online (Google Meet)</option>
                                <option>Online (Zoom)</option>
                                <option>Phone</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Location/Meeting Room</label>
                            <textarea class="form-control" rows="3" 
                                      placeholder="Please provide address or meeting link..."></textarea>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="sendEmail1" checked>
                            <label class="form-check-label" for="sendEmail1">
                                Send email notification to candidate
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Save Schedule</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Interview Schedule Modal 2 -->
    <div class="modal fade" id="scheduleModal2" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Schedule Interview</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Interview Date</label>
                            <input type="date" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Start Time</label>
                            <input type="time" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Interview Type</label>
                            <select class="form-select" required>
                                <option value="">Select Type</option>
                                <option>On-site</option>
                                <option>Online (Google Meet)</option>
                                <option>Online (Zoom)</option>
                                <option>Phone</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Location/Meeting Room</label>
                            <textarea class="form-control" rows="3" 
                                      placeholder="Please provide address or meeting link..."></textarea>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="sendEmail2" checked>
                            <label class="form-check-label" for="sendEmail2">
                                Send email notification to candidate
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Save Schedule</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Function to update application status
        function updateStatus(applicationId, status) {
            if (confirm('Are you sure you want to perform this action?')) {
                console.log(`Update application ${applicationId} status to: ${status}`);
                // Call API or submit form to update
            }
{{ ... }}
        }
        
        // Function to send message
        function sendMessage(candidateId, candidateName) {
            alert(`Send message to ${candidateName} (ID: ${candidateId})`);
        }
        
        // Function to confirm delete
        function confirmDelete(applicationId) {
            if (confirm('Are you sure you want to remove this candidate from the list?')) {
                console.log(`Delete application ${applicationId}`);
                // Call API or submit form to delete
            }
        }
        
        // Function to schedule interview
        function scheduleInterview(candidateId) {
            const form = document.getElementById(`scheduleForm${candidateId}`);
            if (form.checkValidity()) {
                alert('Interview scheduled successfully!');
                // Call API or submit form to save schedule
                const modal = bootstrap.Modal.getInstance(document.getElementById(`scheduleModal${candidateId}`));
                modal.hide();
            } else {
                form.reportValidity();
            }
        }
    </script>
</body>
</html>
