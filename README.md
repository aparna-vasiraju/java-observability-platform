# Java Observability Platform on Kubernetes
A hands-on cloud-native project demonstrating end-to-end 
observability for a Java application running on Kubernetes — built with 
Terraform, Prometheus, Grafana, and Dynatrace.

---

## Project Purpose

Built to bridge performance engineering expertise with modern cloud-native 
tooling — specifically targeting skills required in  
Performance Engineering and Observability Engineer roles.

---

## Architecture

Windows Laptop (16GB RAM)
└── Docker Desktop
└── Minikube (Kubernetes v1.35.1 — 6GB RAM)
├── namespace: default
│   └── Spring PetClinic (Java Spring Boot — 2 replicas)
│       └── Managed by Terraform IaC
├── namespace: dynatrace
│   ├── Dynatrace Operator
│   ├── ActiveGate (SaaS tunnel)
│   └── OneAgent (JVM instrumentation)
├── namespace: monitoring
│   ├── Prometheus (metrics scraping)
│   ├── Grafana (SLO dashboards)
│   └── AlertManager
└── namespace: kube-system
└── K8s control plane

---

## Tech Stack

| Tool | Version | Purpose |
|------|---------|---------|
| Kubernetes | v1.35.1 | Container orchestration |
| Minikube | v1.38.1 | Local K8s cluster |
| Terraform | v1.15.2 | Infrastructure as Code |
| Helm | v4.1.4 | Kubernetes package manager |
| Docker Desktop | v29.3.1 | Container runtime |
| Spring PetClinic | latest | Java Spring Boot app |
| Prometheus | kube-prometheus-stack | Metrics collection |
| Grafana | v13.0.1 | SLO dashboards |
| Dynatrace | SaaS trial | APM + Davis AI |

---

## Repository Structure
java-observability-platform/
├── terraform/
│   ├── main.tf                    # K8s Deployment + Service as IaC
│   └── variables.tf               # Replicas variable
├── kubernetes/
│   └── petclinic-deployment.yaml  # K8s manifest
├── dynatrace/
│   └── dynakube-template.yaml     # Dynatrace operator config
├── docs/
│   └── rca-memory-incident.md     # RCA documentation
└── README.md

---

## What Was Built

### Day 1-2: Kubernetes Setup
- Installed Docker Desktop, Minikube, kubectl on Windows
- Started 6GB Kubernetes cluster using Minikube with Docker driver
- Deployed Spring PetClinic Java app — pod running in 42 seconds
- Verified Pod, Service, Deployment, ReplicaSet all healthy

### Day 3-4: Terraform IaC
- Wrote `main.tf` declaring Kubernetes Deployment and Service as code
- Ran `terraform init` → `terraform plan` → `terraform apply`
- Scaled from 1 to 2 replicas by changing ONE variable
- Demonstrated idempotent infrastructure management

```hcl
# Scale from 1 to 2 — change one line, run terraform apply
variable "replicas" {
  default = 2
}
```

### Day 5-7: Prometheus + Grafana
- Deployed kube-prometheus-stack via Helm — 6 monitoring pods
- Accessed Grafana dashboards — live cluster CPU/memory metrics
- Imported JVM Micrometer dashboard (ID: 4701)
- Observed real-time: CPU 19.1%, Memory 43.7%, all namespaces

### Day 8-9: Dynatrace APM
- Created Dynatrace SaaS trial — tenant: oqy83910
- Deployed Dynatrace Operator + ActiveGate via Helm
- Applied DynaKube configuration — cluster connecting to SaaS
- Explored Dynatrace Playground: 127 services, Davis AI problems,
  method hotspot analysis (12k stacktrace samples), SLI charts

