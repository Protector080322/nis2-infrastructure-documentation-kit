# Backup & Disaster Recovery

This document defines the backup strategy and disaster recovery (DR) procedures, ensuring data integrity and availability in alignment with NIS2 requirements.

## The 3-2-1-1-0 Rule

We follow an enhanced version of the traditional backup rule to ensure maximum protection against hardware failure, human error, and ransomware.

- **3 Copies of Data:** One primary and two backups.
- **2 Different Media:** e.g., Disk and Cloud/Tape.
- **1 Offsite Copy:** To protect against local disasters (fire, flood).
- **1 Immutable/Offline Copy:** To protect against ransomware (Air-gapped or Object Lock).
- **0 Errors:** Verified recovery via regular restoration tests.

## Backup Infrastructure

As shown in the [Enterprise Architecture](../README.md#kmu-enterprise-architecture), backup traffic is isolated in **VLAN 60**.

- **Backup Server:** Centralized management of backup jobs (e.g., Veeam, Proxmox Backup Server).
- **Immutable Repository:** Storage with "write-once-read-many" (WORM) capabilities or Linux-based immutable storage.
- **Offsite / Offline:** Encrypted copies stored in a different physical location or a secure cloud provider (e.g., Azure Blob with Immutable storage).

## Disaster Recovery (DR) Levels

| Level | Strategy | RTO (Target) | RPO (Target) |
|---|---|---|---|
| **Gold** | Real-time Replication / HA | < 1 Hour | Near Zero |
| **Silver** | Daily Backups + Offsite | < 24 Hours | < 24 Hours |
| **Bronze** | Weekly Backups | < 3 Days | < 7 Days |

## Restoration Testing

A backup is only as good as its last successful restore.
1. **Automated Verification:** Boot checks for virtual machine backups.
2. **Monthly Manual Tests:** Randomly selected files and application-level restores.
3. **Annual DR Drill:** Full-scale simulation of a primary site failure.

## Recovery Procedures

In the event of data loss:
1. **Identify** the scope and cause of the loss.
2. **Isolate** affected systems if the cause is cyber-related (ransomware).
3. **Select** the most recent clean recovery point.
4. **Restore** to a sandbox environment first for verification.
5. **Promote** to production.
