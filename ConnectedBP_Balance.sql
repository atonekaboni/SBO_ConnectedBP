-- Created by Amirhossein Tonekaboni, SAP Business One Consultant
-- Date: May 29, 2025
-- Contact: https://linkedin.com/in/atonekaboni
-- Version: 1.0
-- Description: Supercharge your view of Connected Business Partners.
-- Test in a non-production environment before deployment.
-- Licensed under MIT License 
-- AI-Assisted in development and refinement

SELECT
    V.CardCode  AS VendorCode,
    V.CardName  AS VendorName,
    C.CardCode  AS CustomerCode,
    C.CardName  AS CustomerName,
    CAST(ISNULL(C.Balance, 0) AS DECIMAL(19, 2)) AS Customer_AR_Balance,    -- Amount customer owes us (positive)
    CAST(ISNULL(V.Balance * -1, 0) AS DECIMAL(19, 2)) AS Vendor_AP_Liability,  -- Amount we owe the vendor (positive)
    CAST(
        ISNULL(V.Balance + ISNULL(SUM(C.Balance) OVER (PARTITION BY V.CardCode), 0), 0)
        AS DECIMAL(19, 2)) AS Net_Group_Balance      -- Net balance with the group:
                                                     -- Negative: We owe the group
                                                     -- Positive: The group owes us
FROM
    OCRD V
INNER JOIN
    OCRD C ON V.CardCode = C.ConnBP AND C.CardType = 'C'
WHERE
    V.CardType = 'S'
ORDER BY
    V.CardCode, C.CardCode;
