-- Created by Amirhossein Tonekaboni, SAP Business One Consultant
-- Date: May 29, 2025
-- Contact: https://linkedin.com/in/atonekaboni
-- Version: 1.0
-- Description: Supercharge your view of Connected Business Partners.
-- Test in a non-production environment before deployment.
-- Licensed under MIT License 
-- AI-Assisted in development and refinement

USE [SBODemoUS]
GO
/****** Object:  StoredProcedure [dbo].[SBO_SP_TransactionNotification]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[SBO_SP_TransactionNotification] 

@object_type nvarchar(30), 				-- SBO Object Type
@transaction_type nchar(1),			-- [A]dd, [U]pdate, [D]elete, [C]ancel, C[L]ose
@num_of_cols_in_key int,
@list_of_key_cols_tab_del nvarchar(255),
@list_of_cols_val_tab_del nvarchar(255)

AS

begin

-- Return values
declare @error  int				-- Result (0 for no error)
declare @error_message nvarchar (200) 		-- Error string to be displayed
select @error = 0
select @error_message = N'Ok'

--------------------------------------------------------------------------------------------------------------------------------

IF @object_type = '46' AND @transaction_type IN ('A', 'U') -- 46 = Outgoing Payments
BEGIN
    DECLARE @VendorCode NVARCHAR(15)
    SELECT @VendorCode = CardCode FROM OVPM WHERE DocEntry = @list_of_cols_val_tab_del

    -- Check if the vendor is also a connected customer
    DECLARE @ConnectedCustomer NVARCHAR(15)
   SELECT @ConnectedCustomer = ConnBP FROM OCRD WHERE CardCode = @VendorCode

    IF @ConnectedCustomer IS NOT NULL
    BEGIN
        -- Get open balance of the connected customer
        DECLARE @CustomerOpenBalance NUMERIC(19,6)
        SELECT @CustomerOpenBalance = SUM(BalDueDeb - BalDueCred)
        FROM JDT1
        WHERE ShortName = @ConnectedCustomer AND BalDueDeb - BalDueCred <> 0

        IF @CustomerOpenBalance > 0
        BEGIN
            -- Block the outgoing payment
            SET @error = 1
            SET @error_message = N'This vendor is also a customer with outstanding balance. Please clear it first.'
        END
    END
END


--------------------------------------------------------------------------------------------------------------------------------

-- Select the return values
select @error, @error_message

end
