# Linux Load Test

A test environment for a service that will be created by me and put through several standard Linux operations.

## The Ops

Give it an identity → Give it resources → Stress it → Secure it → Monitor it → Clean it up

At first, I am giving the service an identity.

```bash
export SVC_NAME=bgdsvc_dipto
```

This works in the current terminal session.

### Part 1: Create the User
User Creation through a script.

`scripts/01_create_user.sh`

The script is idempotent which means it can be run twice without trying to create the same user again.

## Parts

* **Part 1:** Create the user
* **Part 2:** tmpfs scratch storage
* **Part 3:** Stress testing
* **Part 4:** SSH access
* **Part 5:** SSH hardening
* **Part 6:** Monitoring and cleanup
* **Part 7:** Log rotation
* **Part 8:** Cleanup

## Structure

```text
.
├── README.md
├── observations.md
├── screenshots/
└── scripts/
```

The lab runs inside a fresh Multipass Ubuntu VM.