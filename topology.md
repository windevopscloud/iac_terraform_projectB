flowchart TB
  %% ================= Network Services =================
  subgraph Net[Account D: Network Services]
    TGW[Transit Gateway]
    R53[Route53 Resolver + Private Hosted Zones]
    FW[AWS Network Firewall / Inspection VPC]
  end

  %% ================= External API Account =================
  subgraph Ext[Account A: External API]
    A1[Route53 Public Zone\napi.example.com]
    A2[API Gateway (Regional)\n+ WAF + Shield]
    A3[Cognito User Pool (External)]
    A4[VPC-A]
  end

  %% ================= Internal API Account =================
  subgraph Int[Account B: Internal API]
    B1[API Gateway (Private)\nVPC Endpoint Policy]
    B2[Cognito User Pool (Internal)]
    B3[VPC-B]
  end

  %% ================= EKS + Data Account =================
  subgraph App[Account C: EKS + Data]
    C1[VPC-C (Private Subnets)]
    C2[EKS Cluster (4 nodes)]
    C3[Aurora DB (Multi-AZ)]
    C4[S3 Buckets (Private, KMS)]
    C5[NLB / Endpoint Service]
  end

  %% -------- Networking Relations --------
  A4 <-->|TGW Attach| TGW
  B3 <-->|TGW Attach| TGW
  C1 <-->|TGW Attach| TGW

  TGW --> FW
  TGW --> R53

  %% -------- API Gateway Integrations --------
  A2 -->|VPC Link / PrivateLink| C5
  B1 -->|VPC Link / PrivateLink| C5

  %% -------- Cognito Auth --------
  A2 --> A3
  B1 --> B2

  %% -------- DNS --------
  A1 --- A2
  R53 --- B1
  R53 --- C1
