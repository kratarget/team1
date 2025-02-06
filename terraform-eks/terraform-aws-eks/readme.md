# EKS Module

the goal of this module is to create an EKS cluster with the following features:

- **auto mode:** provides an experience closest to AKS. No node management required.


---

### **Key Benefits of EKS Auto Mode for Your Use Case**
1. **No Infrastructure Management:**
   - AWS handles the provisioning, scaling, and lifecycle of the worker nodes.
   - No need to worry about managing EC2 instances, scaling policies, or node patching.

2. **Simplified Networking:**
   - EKS integrates seamlessly with AWS networking services like **VPC**, **PrivateLink**, and **Elastic Load Balancers**.
   - You can deploy workloads with private endpoints and configure network policies for access control.

3. **Ease of Deployment:**
   - Terraform can manage the entire cluster setup, including the networking and Fargate profiles.
   - GitOps tools like ArgoCD handle application deployment and updates.

4. **Automatic Scaling:**
   - Compute resources scale up and down based on workload demand, with no manual intervention required.

5. **Upgrades and Maintenance:**
   - AWS automatically handles control plane upgrades and applies critical patches to infrastructure.

6. **Cost Efficiency:**
   - Pay for the resources you consume without the overhead of maintaining excess capacity.
   - Ideal for variable workloads, where resource usage fluctuates.


---

### **How Auto Mode Matches AKS**
| **Feature**               | **AKS**                     | **EKS Auto Mode**             |
|---------------------------|-----------------------------|--------------------------------|
| **Managed Nodes**         | Fully managed              | Fully managed via Fargate     |
| **Control Plane Upgrades**| Automatic                  | Automatic                     |
| **Networking**            | Azure VNet integration     | AWS VPC integration           |
| **Scaling**               | Autoscaling enabled        | Fully automatic scaling       |
| **Operational Overhead**  | Minimal                    | Minimal                       |
| **GitOps Ready**          | Compatible with ArgoCD     | Compatible with ArgoCD        |

---

### **Considerations for Auto Mode**
1. **Pod-Level Scaling**: Unlike AKS, which uses node pools for scaling, Auto Mode scales at the pod level. You don’t need to manage node pools explicitly.
2. **Compute Type**: Only **Fargate** is available in Auto Mode, so specialized workloads requiring GPUs or custom EC2 instances are not supported.
3. **Networking Complexity**: Ensure your VPC and security group setup aligns with your private networking needs.

---

Let’s clarify the difference between **EKS Auto Mode** and **EKS Managed Node Groups (MNG)** based on the detailed documentation you shared, and how they compare to AKS.

---

### **EKS Auto Mode**
EKS Auto Mode is a **newer abstraction layer** that extends AWS’s management to cover a broader range of Kubernetes infrastructure, including node pools, networking, storage, and integrations. It’s designed for users who want a **completely hands-off experience**, similar to how AKS operates.

#### **Key Features of EKS Auto Mode:**
1. **Broad Automation**:
   - AWS manages not just the control plane, but also node scaling, storage, networking, and load balancing.
   - Karpenter is used for dynamic scaling of compute resources based on pod requirements.

2. **Immutable Nodes**:
   - Nodes have a fixed lifespan (21 days max, customizable) and are replaced regularly.
   - Secure configurations with SELinux enforced and read-only root files.

3. **Simplified Setup**:
   - Features like load balancing, storage (e.g., EBS), and DNS are built-in, reducing the need for manual configuration.

4. **Customization via NodePools and NodeClasses**:
   - NodePools allow you to configure workload isolation, instance types (e.g., Spot or On-Demand), and ephemeral storage.
   - NodeClasses extend flexibility by enabling custom configurations alongside AWS-managed defaults.

5. **Enhanced Security**:
   - Nodes disallow SSH/SSM access for additional security.
   - Automatic upgrades are managed by AWS while respecting Pod Disruption Budgets (PDBs).

6. **User Focus**:
   - You only interact with Kubernetes workloads and resources; AWS abstracts the underlying infrastructure.

---

### **EKS Managed Node Groups (MNG)**
Managed Node Groups are **an earlier and less abstracted solution** for automating node lifecycle management in EKS. They provide AWS-managed EC2 Auto Scaling groups to handle node provisioning and updates, but the configuration and operation are still under your control.

#### **Key Features of MNG:**
1. **Node Lifecycle Management**:
   - Nodes are automatically updated, patched, and replaced by AWS within the scope of EC2 Auto Scaling groups.
   - Nodes are drained during termination or updates to ensure workload availability.

2. **Customizable with Launch Templates**:
   - Use custom AMIs, specific instance types, additional kubelet arguments, and encrypted EBS volumes via launch templates.

3. **Scaling**:
   - Nodes are part of EC2 Auto Scaling groups that you can configure with scaling policies.
   - Integration with Kubernetes Cluster Autoscaler is available but not as dynamic as Karpenter.

4. **Labels and Taints**:
   - You can assign labels and taints to nodes in Managed Node Groups for workload isolation and scheduling.

5. **Manual Node Customization**:
   - Greater control over instance types, networking (e.g., private or public subnets), and storage.

6. **Security**:
   - AWS publishes patched AMIs for vulnerabilities, but it’s your responsibility to update the AMI versions in your node groups.

---

### **Comparison: EKS Auto Mode vs. EKS Managed Node Groups**

| **Feature**                    | **EKS Auto Mode**                                                                 | **EKS Managed Node Groups (MNG)**                                      |
|---------------------------------|-----------------------------------------------------------------------------------|------------------------------------------------------------------------|
| **Infrastructure Management**  | Fully abstracted (nodes, scaling, storage, networking)                            | AWS manages nodes, but you configure scaling, networking, and storage. |
| **Node Lifecycle**             | Nodes are immutable and replaced every 21 days.                                   | AWS manages lifecycle; you update nodes manually when using custom AMIs. |
| **Scaling**                    | Uses Karpenter for dynamic, pod-driven scaling.                                    | Uses EC2 Auto Scaling and Cluster Autoscaler.                          |
| **Customization**              | NodePools and NodeClasses for instance types, storage, and workload isolation.     | Custom launch templates for instance types and kubelet arguments.      |
| **Storage**                    | Fully managed ephemeral and EBS storage setup.                                    | Must configure EBS storage and encryption manually.                    |
| **Load Balancing**             | Automatic ELB integration for Services and Ingress with lifecycle management.      | ELB integration available, but you must configure lifecycle manually.  |
| **Security**                   | No SSH or SSM access; nodes run with locked-down AMIs.                            | Allows SSH/SSM if configured; AWS publishes patched AMIs.              |
| **Node Upgrades**              | Automatic, with enforced maximum 21-day node lifespan.                            | Manual or semi-automatic; respects Pod Disruption Budgets.             |
| **Networking**                 | Fully automated with Pod IP and service networking handled by AWS.                | Networking must be configured (e.g., VPC, subnets, endpoints).         |
| **Target User**                | For users who want a fully managed, hands-off Kubernetes experience.               | For users who want control over node configuration and scaling.        |

---

### **Comparison with AKS**

| **Feature**                    | **AKS**                                       | **EKS Auto Mode**                               | **EKS MNG**                                      |
|---------------------------------|-----------------------------------------------|------------------------------------------------|-------------------------------------------------|
| **Node Management**            | Fully managed, abstracted node pools.         | Fully abstracted with NodePools and Karpenter. | Managed EC2 instances with Auto Scaling groups. |
| **Scaling**                    | Built-in autoscaler per node pool.            | Karpenter-based dynamic scaling.               | Cluster Autoscaler integration required.        |
| **Networking**                 | Azure VNet integrated.                        | Fully automated, IPv4/IPv6 support.            | Manual VPC and subnet configuration.            |
| **Security**                   | Azure-managed security policies.              | Immutable nodes, SELinux enforced.             | Semi-managed; manual updates for custom AMIs.   |
| **Ease of Use**                | Minimal overhead for configuration.           | Minimal overhead, fully automated.             | Requires more configuration and management.     |

---

### **Key Takeaways**
- **EKS Auto Mode** is the best choice if you want an experience closest to **AKS**. It minimizes operational overhead and abstracts node management entirely.
- **EKS Managed Node Groups** are suitable if you want more control over node configurations, such as using custom AMIs or managing networking and storage explicitly.

### **Recommendation**
Go with **EKS Auto Mode** if:
- You prefer a hands-off experience.
- You don’t want to manage nodes, scaling, or networking explicitly.
- You value dynamic scaling with Karpenter.

Consider **Managed Node Groups** if:
- You need full control over EC2 instances.
- You want to use custom AMIs or specific EC2 features.
- You are comfortable managing networking and scaling policies yourself.

For your use case (minimizing infrastructure management and focusing on workloads), **EKS Auto Mode** is the clear winner. It provides the simplicity and automation you’re looking for while still allowing customization through NodePools and NodeClasses.

