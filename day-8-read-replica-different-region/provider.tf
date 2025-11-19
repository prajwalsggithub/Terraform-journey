provider "aws" {
  alias  = "primary"
  region = "us-west-2"   # ✅ REGION, not AZ
}

provider "aws" {
  alias  = "replica"
  region = "us-east-1"   # ✅ REGION, not AZ
}

# 🔵 Day-8: RDS Read Replica (Cross-Region) — EASY Explanation
# ✅ What is a Read Replica?

# A Read Replica is a copy of your primary RDS database that is used only for read operations.

# Think of it like this:

# Primary RDS  →  Handles writes + reads  
# Read Replica →  Handles read-only traffic

# ✅ Why do we use Read Replicas?
# 1️⃣ Reduce load on your main database

# If your web app is doing many read requests, your primary DB may get slow.

# Read Replica handles:

# Analytics

# Reporting

# High-read traffic

# Read-heavy apps

# 2️⃣ High Availability

# If your primary DB crashes, you can promote the replica to be the new primary.