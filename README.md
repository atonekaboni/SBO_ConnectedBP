# SAP Business One - Connected BP
Supercharge your view of Connected Business Partners

SQL scripts for enhanced management of connected Business Partners in SAP Business One.
*(AI-assisted in code development and refinement.)*

## Scripts

1.  **[ConnectedBP_Balance.sql](https://github.com/atonekaboni/SBO_ConnectedBP/blob/main/ConnectedBP_Balance.sql)**:
    * Query showing Vendors, their linked Customers, individual AR/AP balances, and net group financial position. Use in Query Manager, Formatted Searches, or Alerts.

2.  **[SBO_SP_TransactionNotification_Example.sql](https://github.com/atonekaboni/SBO_ConnectedBP/blob/main/SBO_SP_TransactionNotification_Example.sql)**:
    * Example logic for `SBO_SP_TransactionNotification` to validate/warn on Outgoing Payments to Vendors if their linked Customer has significant overdue balances.

## Usage

1.  **Balance Query**: Copy from `.sql` file and save into SAP B1 Query Manager.
2.  **Transaction Validation SP**:
    **CRITICAL: Review example. Test in a NON-PRODUCTION environment. Backup your database before modifying `SBO_SP_TransactionNotification`. Integrate logic carefully into your existing SP.**

## Disclaimer

* Use these example scripts at your own risk.
* Always test thoroughly before deploying in a live environment.
* Not responsible for any issues. SAP® and SAP Business One® are trademarks of SAP SE.
